class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :remittance_req_no
      t.string :id_req_type, :limit => 20, :null => false
      t.integer :partner_id, :null => false
      t.string :full_name, :limit => 50
      t.string :first_name, :limit => 50
      t.string :last_name, :limit => 50
      t.string :id_type, :limit => 20
      t.string :id_number, :limit => 50
      t.string :id_country
      t.date :id_issue_date
      t.date :id_expiry_date
      t.string :is_verified, :limit => 1, :null => false
      t.date :verified_at
      t.string :verified_by, :limit => 20
      t.string :created_by, :limit => 20, :null => false
      t.string :updated_by, :limit => 20, :null => false
      t.integer :lock_version

      t.timestamps
    end
  end
end
