class RemoveColumnFromInwIdentities < ActiveRecord::Migration
  def change
    remove_column :inw_identities, :partner_id
    remove_column :inw_identities, :full_name
    remove_column :inw_identities, :first_name
    remove_column :inw_identities, :last_name
    remove_column :inw_identities, :created_by
    remove_column :inw_identities, :updated_by
    remove_column :inw_identities, :lock_version
    remove_column :inw_identities, :created_at
    remove_column :inw_identities, :updated_at
  end
end
