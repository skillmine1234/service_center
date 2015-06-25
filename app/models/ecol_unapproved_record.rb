class EcolUnapprovedRecord < ActiveRecord::Base
  belongs_to :ecol_approvable, :polymorphic => true, :unscoped => true
end