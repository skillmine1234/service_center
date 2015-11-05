class BmUnapprovedRecord < ActiveRecord::Base
  belongs_to :bm_approvable, :polymorphic => true, :unscoped => true
  BM_TABLES = ['BmRule','BmBiller','BmAggregatorPayment']
end