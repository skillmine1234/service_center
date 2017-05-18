class Pc2UnapprovedRecord < ActiveRecord::Base
  belongs_to :pc2_approvable, :polymorphic => true, :unscoped => true
  PC2_TABLES = ['Pc2App','Pc2CustAccount']
end
