class RemoveLockVersionInReconciledReturns < ActiveRecord::Migration
  def change
    remove_column :reconciled_returns, :lock_version, :integer
  end
end
