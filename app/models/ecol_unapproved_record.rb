class EcolUnapprovedRecord < ActiveRecord::Base
  belongs_to :ecol_approvable, :polymorphic => true, :unscoped => true
  ECOL_TABLES = ['EcolCustomer','EcolRemitter','UdfAttribute','EcolRule','IncomingFile']
end