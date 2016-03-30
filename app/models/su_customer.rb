class SuCustomer < ActiveRecord::Base
  include Approval
  include SuApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :account_no, :customer_id, :pool_account_no, :pool_customer_id
  validates :account_no, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }, length: {maximum: 20}
  validates_numericality_of :customer_id
  validates_uniqueness_of :customer_id, :scope => :approval_status
  validates :max_distance_for_name, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }, :allow_blank => true

  def to_upcase
    unless self.frozen?
      self.account_no = self.account_no.upcase unless self.account_no.nil?
    end
  end

  
end
