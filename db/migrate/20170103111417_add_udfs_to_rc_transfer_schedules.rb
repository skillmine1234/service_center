class AddUdfsToRcTransferSchedules < ActiveRecord::Migration
  def change
    add_column :rc_transfer_schedule, :udf1, :string, comment: 'the udf 1 for this transfer_schedule'
    add_column :rc_transfer_schedule, :udf2, :string, comment: 'the udf 2 for this transfer_schedule'
    add_column :rc_transfer_schedule, :udf3, :string, comment: 'the udf 3 for this transfer_schedule'
    add_column :rc_transfer_schedule, :udf4, :string, comment: 'the udf 4 for this transfer_schedule'
    add_column :rc_transfer_schedule, :udf5, :string, comment: 'the udf 5 for this transfer_schedule'
    
    add_column :rc_transfer_schedule, :rc_app_id, :integer, comment: 'the rc_app associated with this transfer_schedule'
  end
end
