class ImtUnapprovedRecord < ActiveRecord::Base
  belongs_to :imt_approvable, :polymorphic => true, :unscoped => true
  IMT_TABLES = ['ImtRule','ImtCustomer', 'IncomingFile']
end