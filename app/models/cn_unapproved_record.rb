class CnUnapprovedRecord < ActiveRecord::Base
  belongs_to :cn_approvable, :polymorphic => true, :unscoped => true
  CN_TABLES = ['IncomingFile']
end