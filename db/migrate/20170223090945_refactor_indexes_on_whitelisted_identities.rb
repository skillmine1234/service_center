class RefactorIndexesOnWhitelistedIdentities < ActiveRecord::Migration[7.0]
  def change    
    # add_index :whitelisted_identities, [:partner_id, :id_type, :id_number, :id_country, :id_issue_date, :id_expiry_date, :is_revoked, :created_for_req_no, :approval_status], name: :in_wl_1
    # add_index :whitelisted_identities, [:partner_id, :bene_account_no, :bene_account_ifsc, :id_expiry_date, :is_revoked, :created_for_req_no, :approval_status], name: :in_wl_2
    # add_index :whitelisted_identities, [:partner_id, :rmtr_code, :id_expiry_date, :is_revoked, :created_for_req_no, :approval_status], name: :in_wl_3
    
    # add_index :inward_remittances, [:partner_code, :rmtr_wl_id, :bene_wl_id], name: :in_inw_wl_1
    # add_index :inward_remittances, [:partner_code, :rmtr_needs_wl, :bene_needs_wl], name: :in_inw_wl_2        
  end
end
