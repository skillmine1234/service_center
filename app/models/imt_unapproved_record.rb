class ImtUnapprovedRecord < ActiveRecord::Base
  belongs_to :imt_approvable, :polymorphic => true, :unscoped => true
  IMT_TABLES = ['ImtCustomer', 'IncomingFile']
end