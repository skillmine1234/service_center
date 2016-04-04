class AddIndexOnColumnsInInwardRemittances < ActiveRecord::Migration
  def up
    add_index(:inward_remittances, [:status_code, :bank_ref, :bene_account_no, :req_transfer_type, :transfer_type], name: "idx_inrw_columns")
  end

  def down
    remove_index(:inw_remittances, :name => 'idx_inrw_columns')
  end
end
