class AddColumnsBeneNameToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :bene_name, :string, :limit => 25, :comment => "the full name of the beneficiary which will be used to call FCR API" 
    add_column :rc_transfers, :bene_account_ifsc, :string, :limit => 11, :comment => "the ifsc code for the beneficiary account"     
  end
end