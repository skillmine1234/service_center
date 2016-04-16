class SuUnapprovedRecord < ActiveRecord::Base
  belongs_to :su_approvable, :polymorphic => true, :unscoped => true
  SU_TABLES = ['SuCustomer','IncomingFile']
end