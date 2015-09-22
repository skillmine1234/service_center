class AddNotifyToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :notified_at, :datetime
    add_column :ecol_transactions, :notify_status, :string, :limit => 1
    add_column :ecol_transactions, :notify_ref, :string, :limit => 64
    add_column :ecol_transactions, :notify_result, :string, :limit => 1000
  end
end
