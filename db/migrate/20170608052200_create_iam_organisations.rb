class CreateIamOrganisations < ActiveRecord::Migration
  def change
    create_table :iam_organisations, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :name, limit: 255, null: false, comment: 'the name of the organisation'
      t.string :org_uuid, limit: 255, null: false, comment: 'the UUID of the organisation as available in DP'
      t.string :on_vpn, limit: 1, null: false, comment: 'the flag to indicate if the customer is using VPN'
      t.string :cert_dn, limit: 255, comment: 'to specify the DN of the certificate (required when then customer is not using VPN)'
      t.string :source_ips, limit: 4000, comment: 'to specify the list of source ip-address’s (required when the customer is not using VPN)'
      t.string :is_enabled, limit: 1, null: false, comment: 'the flag which indicates whether this user is enabled or not'
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.integer :lock_version, null: false, default: 0, comment: 'the version number of the record, every update increments this by 1'
      t.approval_columns
      t.index([:org_uuid, :approval_status], :unique => true, name: 'iam_organisations_01')
    end
  end
end
