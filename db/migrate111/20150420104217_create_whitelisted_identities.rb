class CreateWhitelistedIdentities < ActiveRecord::Migration[7.0]
  def change
    create_table :whitelisted_identities do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :partner_id, :null => false
      t.string :full_name, :limit => 50
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.string :id_type, :limit => 20
      t.string :id_number, :limit => 50
      t.string :id_country
      t.date :id_issue_date
      t.date :id_expiry_date
      t.string :is_verified, :limit => 1
      t.date :verified_at
      t.string :verified_by, :limit => 20
      t.integer :first_used_with_txn_id
      t.integer :last_used_with_txn_id
      t.integer :times_used
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version

      t.timestamps
    end

    add_index(:whitelisted_identities, :last_used_with_txn_id, order: {last_used_with_txn_id: :asc})
  end
end
