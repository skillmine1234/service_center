class BmAuditLog < ActiveRecord::Base
  belongs_to :bm_auditable, :polymorphic => true
end