class AddColumnsToRcTransferSchedules < ActiveRecord::Migration
  def change
    add_column :rc_transfer_schedule, :bene_name, :string, :limit => 25, :comment => "the beneficiaary  name which we used in FCR call" 
  end
end
