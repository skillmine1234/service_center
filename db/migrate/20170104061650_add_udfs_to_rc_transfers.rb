class AddUdfsToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :udf1, :string, comment: 'the udf 1 for this rc_transfer'
    add_column :rc_transfers, :udf2, :string, comment: 'the udf 2 for this rc_transfer'
    add_column :rc_transfers, :udf3, :string, comment: 'the udf 3 for this rc_transfer'
    add_column :rc_transfers, :udf4, :string, comment: 'the udf 4 for this rc_transfer'
    add_column :rc_transfers, :udf5, :string, comment: 'the udf 5 for this rc_transfer'
    
    add_column :rc_transfers, :rc_app_id, :integer, comment: 'the rc_app associated with this rc_transfer'
  end
end
