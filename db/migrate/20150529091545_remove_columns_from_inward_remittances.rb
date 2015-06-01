class RemoveColumnsFromInwardRemittances < ActiveRecord::Migration
  def change
    remove_column :inward_remittances, :bene_first_name
    remove_column :inward_remittances, :bene_last_name
    remove_column :inward_remittances, :rmtr_first_name
    remove_column :inward_remittances, :rmtr_last_name
  end
end
