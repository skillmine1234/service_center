class AddIndexesInInwardRemittances < ActiveRecord::Migration
  def change
    if Rails.env == "production"
      if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
        execute "create index indx_req_timestamp on inward_remittances (trunc(req_timestamp));"
      end
      add_index :inward_remittances, [:bank_ref, :partner_code , :purpose_code], :name => "inw_index_on_codes"
    end
  end
end
