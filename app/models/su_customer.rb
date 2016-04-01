class SuCustomer < ActiveRecord::Base
  include Approval
  include SuApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'

  validates_presence_of :account_no, :customer_id, :pool_account_no, :pool_customer_id
  validates_numericality_of :account_no, :customer_id, :pool_account_no, :pool_customer_id
  validates_uniqueness_of :account_no, :scope => [:customer_id, :approval_status]
  validates :max_distance_for_name, :numericality => {:greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }, :allow_blank => true
  validates :customer_id, length: { maximum: 15 }
  [:account_no, :pool_account_no, :pool_customer_id].each do |column|
    validates column, length: { maximum: 20 }
  end
end
