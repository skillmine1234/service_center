class AddUniqueIndexOnReconciledReturns < ActiveRecord::Migration
  def change
    add_index :reconciled_returns, [:bank_ref_no, :txn_type], unique: true, name: 'reconciled_returns_01'
  end
end
