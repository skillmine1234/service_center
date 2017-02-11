class AddIndexesOnInwardRemittances < ActiveRecord::Migration
  def change
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      add_index :inward_remittances, "to_char(req_timestamp, 'YYYY'), bene_account_no, bene_account_ifsc, status_code, partner_code", name: 'inw_index_02'
    end
    add_index :inward_remittances, [:req_timestamp, :status_code, :partner_code], name: 'inw_index_03'
  end
end
