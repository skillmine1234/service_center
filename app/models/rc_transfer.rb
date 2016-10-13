class RcTransfer < ActiveRecord::Base
  has_many :rc_audit_steps, :as => :rc_auditable
  has_one :rc_transfer_schedule, :foreign_key => 'code', :primary_key => 'rc_transfer_code'
end
