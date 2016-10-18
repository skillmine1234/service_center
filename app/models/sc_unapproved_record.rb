class ScUnapprovedRecord < ActiveRecord::Base
  belongs_to :sc_approvable, :polymorphic => true, :unscoped => true
  SC_TABLES = ['ScBackend']
end