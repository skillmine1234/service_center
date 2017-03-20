class IndexOnAdvancedSearchColumnsWl < ActiveRecord::Migration
  def change
    add_index :whitelisted_identities, [:partner_id, :full_name, :rmtr_code, :bene_account_no, :bene_account_ifsc], name: 'IN_WL_4'
  end
end
