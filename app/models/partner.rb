class Partner < ActiveRecord::Base
  audited
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :code, :enabled, :name, :account_no, :txn_hold_period_days,
                        :customer_id, :remitter_email_allowed, :remitter_sms_allowed,
                        :beneficiary_email_allowed, :beneficiary_sms_allowed, :allow_imps, 
                        :allow_neft, :allow_rtgs, :country
  validates_uniqueness_of :code
  validates :low_balance_alert_at, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => '9e20'.to_f, :allow_nil => true }
  validates :account_no, :numericality => {:only_integer => true}, length: {in: 10..16}
  validates :account_ifsc, format: {with: /\A[A-Z|a-z]{4}[0][A-Za-z0-9]{6}+\z/, :allow_blank => true }
  validates :txn_hold_period_days, :numericality => { :greater_than => 0, :less_than => 16}
  validates :code, format: {with: /\A[A-Za-z0-9]+\z/}, length: {maximum: 10, minimum: 1}
  validates :name, format: {with: /\A[A-Za-z0-9\s]+\z/}
  validates :customer_id, :numericality => {:only_integer => true}
  validates :mmid, :numericality => {:only_integer => true}, length: {maximum: 7, minimum: 7}, :allow_blank => true
  validates :mobile_no, :numericality => {:only_integer => true}, length: {maximum: 10, minimum: 10}, :allow_blank => true

  validate :imps_and_mmid
  validate :check_email_addresses

  def imps_and_mmid
    errors.add(:mmid,"is mandatory") if allow_imps == 'Y' and mmid.to_s.empty?
    errors.add(:mobile_no,"is mandatory") if allow_imps == 'Y' and mobile_no.to_s.empty?
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
      errors.add(email_id.to_sym, "are invalid due to #{invalid_ids.join(',')}") unless invalid_ids.empty?
    end
  end

  def country_name
    country = ISO3166::Country[self.country]
    country.translations[I18n.locale.to_s] || country.name rescue nil
  end
end
