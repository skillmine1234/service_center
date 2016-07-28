class PcUnapprovedRecord < ActiveRecord::Base
  belongs_to :pc_approvable, :polymorphic => true, :unscoped => true
  PC_TABLES = ['PcApp','PcFeeRule', 'PcProgram']
end
