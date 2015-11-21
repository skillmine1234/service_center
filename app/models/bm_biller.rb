class BmBiller < ActiveRecord::Base
  include Approval
  include BmApproval
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :biller_code, :biller_name, :biller_category, :biller_location, :processing_method, :is_enabled, :num_params
  
  validates_uniqueness_of :biller_code, :scope => :approval_status
  
  validates :biller_code, format: {with: /\A[a-z|A-Z|0-9]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9]}' }
  validates :biller_name, :biller_location, format: {with: /\A[a-z|A-Z|0-9\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9\s]}' }
  validates :param1_name, :param2_name, :param3_name, :param4_name, :param5_name, format: {with: /\A[a-z|A-Z|0-9|\(|\)|\/|\.\s]+\z/, :message => 'Invalid format, expected format is : {[a-z|A-Z|0-9|\(|\)|\.\s]}'}, :allow_blank =>true
  
  def self.options_for_processing_method
    [['Presentment','T'],['Payee','P'],['Both','A'],['Recharge','R']]
  end
end