class RcTransfer < ActiveRecord::Base
  has_many :rc_audit_steps, :as => :rc_auditable
end
