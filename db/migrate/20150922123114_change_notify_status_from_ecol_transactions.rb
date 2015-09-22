class ChangeNotifyStatusFromEcolTransactions < ActiveRecord::Migration
  def change
    change_column :ecol_transactions, :notify_status, :string, :limit => 50
  end
end
