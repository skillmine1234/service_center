class AddNotifyColumnsToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :notify_attempt_no, :integer, :limit => 8
    add_column :ecol_transactions, :notify_attempt_at, :datetime
  end
end
