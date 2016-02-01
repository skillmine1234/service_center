class IncomingFileRecord < ActiveRecord::Base
  belongs_to :incoming_file

  lazy_load :record_txt, :fault_bitstream
end