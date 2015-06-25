class AddEcolRemitterIdToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :ecol_remitter_id, :integer
  end
end
