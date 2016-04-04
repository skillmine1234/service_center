class AddIndexOnColumnsInFundsTransfers < ActiveRecord::Migration
  def up
    add_index(:funds_transfers, [:status_code, :bank_ref, :bene_account_no, :req_transfer_type, :transfer_type], name: "idx_ft_columns")
  end

  def down
    remove_index(:funds_transfers, :name => 'idx_ft_columns')
  end
end
