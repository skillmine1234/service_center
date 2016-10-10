class AddRequiredColumnsToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :customer_name, :string, :limit => 100, :comment => 'the name of the customer'
    add_column :rc_transfers, :customer_id, :string, :limit => 50, :comment => 'the unique id of the customer'        
    add_column :rc_transfers, :mobile_no, :string, :limit => 10, :comment => 'the mobile no of the customer'    
    add_column :rc_transfers, :broker_uuid, :string, :limit => 255, :null => false, :comment => "the UUID of the broker"
  end
end
