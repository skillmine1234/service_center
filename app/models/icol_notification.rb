class IcolNotification < ActiveRecord::Base
  lazy_load :fault_bitstream
  has_many :icol_notify_steps
end