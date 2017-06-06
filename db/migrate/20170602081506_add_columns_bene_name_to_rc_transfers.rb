class AddColumnsBeneNameToRcTransfers < ActiveRecord::Migration
  def change
    add_column :rc_transfers, :bene_name, :string, :limit => 25, :comment => "the beneficiaary  name which we used in FCR call" 
    add_column :rc_transfers, :bene_account_ifsc, :string, :limit => 11, :comment => "the beneficiary account IFSC"     
  end
end
