class AddIndexOnReconciledReturns < ActiveRecord::Migration
  def change
    add_index :reconciled_returns, :bank_ref_no
  end
end
