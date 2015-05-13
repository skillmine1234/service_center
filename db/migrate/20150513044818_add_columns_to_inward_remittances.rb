class AddColumnsToInwardRemittances < ActiveRecord::Migration
  def change
    add_column :inward_remittances, :beneficiary_type, :string, :limit => 1
    add_column :inward_remittances, :remitter_type, :string, :limit => 1
    add_column :inward_remittances, :fault_code, :string, :limit => 50
    add_column :inward_remittances, :fault_reason, :string, :limit => 1000
  end
end
