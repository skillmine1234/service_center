class Partner < ActiveRecord::Base
  include Approval2::ModelAdditions

  SERVICE_NAMES = %w(INW INW2)
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  belongs_to :guideline, :foreign_key =>'guideline_id', :class_name => 'InwGuideline'
  has_one :partner_lcy_rate, :foreign_key => 'partner_code', :primary_key => 'code'

  validates_presence_of :code, :enabled, :name, :account_no, :txn_hold_period_days,
                        :customer_id, :remitter_email_allowed, :remitter_sms_allowed,
                        :allow_imps, :allow_neft, :allow_rtgs, :country, :account_ifsc,
                        :identity_user_id, :add_req_ref_in_rep, :add_transfer_amt_in_rep,
                        :notify_on_status_change
  validates_uniqueness_of :code, :scope => :approval_status
  validates :low_balance_alert_at, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :account_no, :numericality => {:only_integer => true}, length: {in: 10..16}
  validates :account_ifsc, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/, :allow_blank => true, message: "invalid format - expected format is : {[A-Z|a-z]{4}[0][A-Za-z0-9]{6}}" }
  validates :txn_hold_period_days, :numericality => { :greater_than_or_equal_to => 0, :less_than => 16}
  validates :code, format: {with: /\A[A-Za-z0-9]+\z/, message: "invalid format - expected format is : {[A-Za-z0-9\s]}"}, length: {maximum: 10, minimum: 1}
  validates_presence_of :app_code, message: 'Mandatory if notify on status change is checked', :if => :notify_on_status_change?
  validates :app_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {minimum: 5, maximum: 20}, :if => :notify_on_status_change?
  validates :name, format: {with: /\A[A-Za-z0-9\s]+\z/, message: "invalid format - expected format is : {[A-Za-z0-9\s]}"}
  validates :customer_id, :numericality => {:only_integer => true}, length: {maximum: 15}
  validates :mmid, :numericality => {:only_integer => true}, length: {maximum: 7, minimum: 7}, :allow_blank => true
  validates :mobile_no, :numericality => {:only_integer => true}, length: {maximum: 10, minimum: 10}, :allow_blank => true
  validates_length_of :add_req_ref_in_rep, :add_transfer_amt_in_rep, minimum: 1, maximum: 1

  validate :imps_and_mmid
  validate :check_email_addresses
  
  validate :whitelisting
  validate :transfer_types
  
  validate :presence_of_iam_cust_user
  
  validate :should_allow_neft?, if: "allow_neft=='Y'"
  validate :should_allow_imps?, if: "allow_imps=='Y'"

  after_create :create_lcy_rate

  def create_lcy_rate
    if partner_lcy_rate.nil?
      PartnerLcyRate.create(partner_code: code, rate: 1, approval_status: 'A')
    end
  end

  def whitelisting
    errors.add(:hold_for_whitelisting, "Allowed only when service is INW2 and Will Whitelist is true") if (hold_for_whitelisting == 'Y' && (will_whitelist == 'N' || service_name == 'INW'))
    errors.add(:txn_hold_period_days, "Allowed only when Hold for Whitelisting is true") if (hold_for_whitelisting == 'N' && txn_hold_period_days != 0)
    errors.add(:will_send_id, "Allowed only when Will Whitelist is true") if will_whitelist == 'N' && will_send_id == 'Y'
    errors.add(:remitter_sms_allowed, "Allowed only when service is INW") if service_name == 'INW2' && remitter_sms_allowed == 'Y'
    errors.add(:remitter_email_allowed, "Allowed only when service is INW") if service_name == 'INW2' && remitter_email_allowed == 'Y'
  end
  
  def transfer_types
    errors.add(:allow_neft, "Allowed only if the chosen guideline supports NEFT") if allow_neft == 'Y' && guideline.allow_neft == 'N'
    errors.add(:allow_rtgs, "Allowed only if the chosen guideline supports RTGS") if allow_rtgs == 'Y' && guideline.allow_rtgs == 'N'
    errors.add(:allow_imps, "Allowed only if the chosen guideline supports IMPS") if allow_imps == 'Y' && guideline.allow_imps == 'N'
  end

  def notify_on_status_change?
    true if self.notify_on_status_change == 'Y'
  end

  def imps_and_mmid
    errors.add(:mmid,"MMID Mandatory for IMPS") if allow_imps == 'Y' and mmid.to_s.empty?
    errors.add(:mobile_no,"Mobile No Mandatory for IMPS") if allow_imps == 'Y' and mobile_no.to_s.empty?
  end

  def check_email_addresses
    ["ops_email_id","tech_email_id"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "is invalid") unless invalid_ids.empty?
    end
  end

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name rescue nil
  end
  
  def self.options_for_auto_match_rule
    [['None','N'],['Any','A']]
  end
  
  def presence_of_iam_cust_user
    errors.add(:identity_user_id, 'IAM Customer User does not exist for this username') if IamCustUser.find_by(username: identity_user_id).nil?
  end
  
  def should_allow_neft?
    fcr_customer = Fcr::Customer.find_by_cod_cust_id(self.code)
    if fcr_customer.nil?
      errors.add(:code, "no record found in FCR for #{self.code}")
    else
      errors.add(:allow_neft, "NEFT is not allowed for #{self.code} as the data setup in FCR is invalid") unless fcr_customer.transfer_type_allowed?('NEFT')
    end
  end
  
  def should_allow_imps?
    fcr_customer = Fcr::Customer.find_by_cod_cust_id(self.code)
    atom_customer_by_cust_id = Atom::Customer.find_by_customerid(self.code)
    atom_customer_by_debit_acct = Atom::Customer.find_by_accountno(self.account_no)

    if fcr_customer.present? && atom_customer_by_cust_id.present? && atom_customer_by_debit_acct.present?
      errors.add(:account_no, "IMPS is not allowed for #{self.account_no} as the data setup in ATOM is invalid") unless atom_customer_by_debit_acct.imps_allowed?(fcr_customer.ref_phone_mobile)
    else
      errors.add(:code, "no record found in FCR for #{self.code}") if fcr_customer.nil?
      errors.add(:code, "no record found in ATOM for #{self.code}") if atom_customer_by_cust_id.nil?
      errors.add(:account_no, "no record found in ATOM for #{self.account_no}") if atom_customer_by_debit_acct.nil?
    end
  end
end