class AddColumnsToImtTransfers < ActiveRecord::Migration
  def change
    add_column :imt_transfers, :app_id, :string, :limit => 20, :comment => "the app Id issued to the customer"  
    db.execute "UPDATE imt_transfers SET app_id = 'A'"
    change_column :imt_transfers, :app_id, :string, :null => false, :limit => 20, :comment => "the app Id issued to the customer"     
    add_column :imt_transfers, :settlement_at, :datetime, :comment => "the datetime when the settlement happened"
    add_column :imt_transfers, :settlement_status, :string, :limit => 15, :comment => "the settlement status of the IMT transaction"
    add_column :imt_transfers, :settlement_attempt_no, :integer, :comment => "the attempt number which has been made for IMT settlement"
    add_column :imt_transfers, :settlement_bank_ref, :string, :comment => "the unique reference no which has been sent to FCR api while doing settlement"
    add_column :imt_transfers, :incoming_file_record_id, :integer, :comment => "the foreign key to the imt_incoming_records table, which has been for settlement"
    add_column :imt_transfers, :file_name, :string, :limit => 100, :comment => "the name of the file which has been used for settlement"
  end
  def db
    ActiveRecord::Base.connection
  end  
end
