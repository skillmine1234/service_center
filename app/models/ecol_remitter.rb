class EcolRemitter < ActiveRecord::Base
  include UdfValidation
  include EcolCustomersHelper
  include Approval
  include EcolApproval
  include EcolRemitterValidation
  
  belongs_to :created_user, :foreign_key =>'created_by', :class_name => 'User'
  belongs_to :updated_user, :foreign_key =>'updated_by', :class_name => 'User'
  
  belongs_to :ecol_customer
  
  def udfs
    UdfAttribute.where("is_enabled=?",'Y').order("id asc")
  end
end
