class BmAggregatorPayment < ActiveRecord::Base
  include Approval
  include BmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :cod_acct_no, :neft_sender_ifsc, :bene_acct_no, :bene_account_ifsc, :status

end