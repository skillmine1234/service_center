class AddBalAvailableToInwardRemittances < ActiveRecord::Migration
  def change
    add_column :inward_remittances, :bal_available, :float
  end
end
