class FpUnapprovedRecord < ActiveRecord::Base
  belongs_to :fp_approvable, :polymorphic => true, :unscoped => true
  FP_TABLES = []
end