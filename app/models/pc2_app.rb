class Pc2App < ActiveRecord::Base
  include Approval2::ModelAdditions
  include ServiceNotification
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates :customer_id, presence: true, :numericality => {:only_integer => true}, length: { maximum: 15 }
  validates_presence_of :app_id, :identity_user_id
  validates_uniqueness_of :customer_id, :scope => [:app_id, :approval_status]
  validate :presence_of_iam_cust_user

  has_many :pc2_cust_accounts, :primary_key => 'customer_id', :foreign_key => 'customer_id', :class_name => 'Pc2CustAccount'
  
  def presence_of_iam_cust_user
    errors.add(:identity_user_id, 'IAM Customer User does not exist for this username') unless IamCustUser.iam_cust_user_exists?
  end

  def template_variables
    user = IamCustUser.find_by(username: identity_user_id)
    { username: user.try(:username), first_name: user.try(:first_name), last_name: user.try(:last_name), mobile_no: user.try(:mobile_no),
      email: user.try(:email), service_name: 'ExpenseCard', customer_id: customer_id, app_id: app_id }
  end
end
