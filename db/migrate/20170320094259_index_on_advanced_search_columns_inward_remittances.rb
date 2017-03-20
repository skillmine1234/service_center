class IndexOnAdvancedSearchColumnsInwardRemittances < ActiveRecord::Migration
  def change
    remove_index :inward_remittances, :status_code
    remove_index :inward_remittances, :transfer_type
    remove_index :inward_remittances, :bene_account_no
    remove_index :inward_remittances, :req_transfer_type
    remove_index :inward_remittances, :bank_ref
    add_index :inward_remittances, [:partner_code, :status_code, :notify_status, :req_no, :rmtr_code,
                                    :bene_account_no, :bene_account_ifsc, :bank_ref, :rmtr_full_name,
                                    :transfer_type, :req_transfer_type, :transfer_amount, :req_timestamp],
                                    name: 'INW_INDEX_04'
  end
end
