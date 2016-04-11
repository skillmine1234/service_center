class CreateIcIncomingFiles < ActiveRecord::Migration
  def change
    create_table :ic_incoming_files, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string  :file_name, :limit => 50, :comment => "the name of the incoming_file"    
      t.string :corp_customer_id, :limit => 15, :comment => "the customer id of the corporate, who is paying the supplier od"
      t.string :pm_utr, :limit => 64, :comment => "the transaction unique ref No of NEFT done by corporate"
    end
    add_index :ic_incoming_files, :file_name, :name => "ic_file_index", :unique => true
  end
end
