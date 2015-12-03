class CreateInwardRemittances < ActiveRecord::Migration
  def change
    create_table :inward_remittances do |t|
      t.string :req_no, :null => false
      t.string :req_version, :limit => 10, :null => false
      t.datetime :req_time, :null => false
      t.string :partner_code, :limit => 20, :null => false
      t.string :rmtr_full_name
      t.string :rmtr_first_name
      t.string :rmtr_last_name
      t.string :rmtr_address1
      t.string :rmtr_address2
      t.string :rmtr_address3
      t.string :rmtr_postal_code
      t.string :rmtr_city
      t.string :rmtr_state
      t.string :rmtr_country
      t.string :rmtr_email_id
      t.string :rmtr_mobile_no
      t.integer :rmtr_identity_count, :null => false
      t.string :bene_full_name
      t.string :bene_first_name
      t.string :bene_last_name
      t.string :bene_address1
      t.string :bene_address2
      t.string :bene_address3
      t.string :bene_postal_code
      t.string :bene_city
      t.string :bene_state
      t.string :bene_country
      t.string :bene_email_id
      t.string :bene_mobile_no
      t.integer :bene_identity_count, :null => false
      t.string :bene_account_no
      t.string :bene_account_ifsc
      t.string :transfer_type, :limit => 4
      t.string :transfer_ccy, :limit => 5
      t.decimal :transfer_amount
      t.string :rmtr_to_bene_note
      t.string :purpose_code, :limit => 5
      t.string :status_code, :limit => 25
      t.string :bank_ref, :limit => 20
      t.string :bene_ref, :limit => 20
      t.string :rep_no
      t.string :rep_version, :limit => 10
      t.datetime :rep_timestamp
      t.string :review_reqd, :limit => 1, :default => 'N'
      t.string :review_pending, :limit => 1, :default => 'N'
      t.integer :attempt_no, :null => false

      t.timestamps
    end

    add_index :inward_remittances, [:req_no,:partner_code,:attempt_no], :unique => true, :name => :remittance_unique_index
  end
end
