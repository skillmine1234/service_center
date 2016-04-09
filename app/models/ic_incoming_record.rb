class IcIncomingRecord < ActiveRecord::Base  
  belongs_to :incoming_file_record
  belongs_to :incoming_file, :foreign_key => 'file_name', :primary_key => 'file_name'
  has_many :ic_audit_steps, :as => :ic_auditable
end