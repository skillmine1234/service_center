class InwAuditLog < ActiveRecord::Base
  attr_accessible :inward_remittance_id, :reply_bitstream, :request_bitstream
end
