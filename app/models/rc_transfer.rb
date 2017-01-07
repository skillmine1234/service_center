class RcTransfer < ActiveRecord::Base
  has_many :rc_audit_steps, :as => :rc_auditable
  has_one :rc_transfer_schedule, :foreign_key => 'code', :primary_key => 'rc_transfer_code'
  belongs_to :rc_app
  
  store :udf1, accessors: [:udf1_name, :udf1_type, :udf1_value], coder: JSON
  store :udf2, accessors: [:udf2_name, :udf2_type, :udf2_value], coder: JSON
  store :udf3, accessors: [:udf3_name, :udf3_type, :udf3_value], coder: JSON
  store :udf4, accessors: [:udf4_name, :udf4_type, :udf4_value], coder: JSON
  store :udf5, accessors: [:udf5_name, :udf5_type, :udf5_value], coder: JSON
end
