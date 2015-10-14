class BmBiller < ActiveRecord::Base
  include Approval
  include BmApproval
  
  after_initialize :set_num_params
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  validates_presence_of :biller_code, :biller_name, :biller_category, :biller_location, :processing_method, :is_enabled, :num_params
  
  validates_uniqueness_of :biller_code, :scope => :approval_status
  
  def set_num_params
    self.num_params = 0 if self.new_record?
  end
  
  def self.options_for_processing_method
    [['Presentment','T'],['Payee','P'],['Both','A']]
  end
end