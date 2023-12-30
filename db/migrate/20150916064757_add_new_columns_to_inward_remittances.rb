class AddNewColumnsToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :service_id, :string
    add_column :inward_remittances, :reconciled_at, :date
  end
end
