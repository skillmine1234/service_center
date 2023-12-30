class AddBalAvailableToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :bal_available, :number
  end
end
