class AddIndexOnColumnsInInwardRemittances < ActiveRecord::Migration
  def up
    add_index :inward_remittances, :status_code
    add_index :inward_remittances, :bank_ref
    add_index :inward_remittances, :bene_account_no
    add_index :inward_remittances, :req_transfer_type
    add_index :inward_remittances, :transfer_type
  end

  def down
    remove_index :inward_remittances, :status_code
    remove_index :inward_remittances, :bank_ref
    remove_index :inward_remittances, :bene_account_no
    remove_index :inward_remittances, :req_transfer_type
    remove_index :inward_remittances, :transfer_type
  end
end
