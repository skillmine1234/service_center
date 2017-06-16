class CreateFtSafTransfers < ActiveRecord::Migration
  def change
    create_table :ft_saf_transfers, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :app_uuid, :null => true, :limit => 255, :comment => "the UUID of the instance of the application"
      t.string :customer_id, :limit => 15, :null => true, :comment => "the ID of the customer"
      t.string :req_no, :limit => 32, :null => false, :comment => "the unique request number sent by the client"
      t.string :op_name, :null => false, :limit => 32, :comment => "the name of the operation from where the transaction has come"
      t.string :req_transfer_type, :limit => 4, :comment => "the type of the transfer e.g. NEFT/IMPS/FT/RTGS"     
      t.datetime :req_timestamp, :null => false, :comment => "the SYSDATE when the request was received"
      t.datetime :rep_timestamp, :comment => "the SYSDATE when the reply was sent to the client"    
      t.text :req_bitstream, :comment => "the full request payload as received from the client"
      t.text :rep_bitstream, :comment => "the full reply payload as sent to the client"
      
      t.index([:customer_id, :req_no], :unique => true, :name => 'uk_ft_saf_transfers_01')
      t.index([:req_timestamp, :req_transfer_type, :customer_id], :name => 'uk_ft_saf_transfers_02')     
    end
  end
end
