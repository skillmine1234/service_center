class CreateEcolTransactions < ActiveRecord::Migration
  def change
    create_table :ecol_transactions do |t|
      t.string :status, :limit => 20, :default => 'N', :null => false
      t.string :transfer_type, :limit => 4, :null => false
      t.string :transfer_unique_no, :limit => 64, :null => false
      t.string :transfer_status, :limit => 25, :null => false
      t.date :transfer_date, :null => false
      t.string :transfer_ccy, :limit => 5, :null => false
      t.decimal :transfer_amount, :null => false
      t.string :rmtr_ref, :limit => 64
      t.string :rmtr_full_name, :limit => 255
      t.string :rmtr_address, :limit => 255
      t.string :rmtr_account_type, :limit => 10
      t.string :rmtr_account_no, :limit => 64, :null => false
      t.string :rmtr_account_ifsc, :limit => 20, :null => false
      t.string :bene_full_name, :limit => 255
      t.string :bene_account_type, :limit => 10
      t.string :bene_account_no, :limit => 64, :null => false
      t.string :bene_account_ifsc, :limit => 20, :null => false
      t.string :rmtr_to_bene_note, :limit => 255
      t.datetime :received_at, :null => false
      t.datetime :tokenized_at
      t.string :tokenzation_status, :limit => 1
      t.string :customer_code, :limit => 15
      t.string :customer_subcode, :limit => 15
      t.string :remitter_code, :limit => 28
      t.datetime :validated_at
      t.string :vaidation_status, :limit => 1
      t.datetime :credited_at
      t.string :credit_status, :limit => 1
      t.string :credit_ref, :limit => 64
      t.integer :credit_attempt_no
      t.string :rmtr_email_notify_ref, :limit => 64
      t.string :rmtr_sms_notify_ref, :limit => 64
      t.datetime :settled_at
      t.string :settle_status, :limit => 1
      t.string :settle_ref, :limit => 64
      t.integer :settle_attempt_no
      t.datetime :fault_at
      t.string :fault_code, :limit => 50
      t.string :fault_reason, :limit => 1000
      
      t.timestamps null: false
    end
    
    add_index :ecol_transactions, [:transfer_type, :transfer_unique_no], :unique => true, :name => :ecol_transaction_unique_index
  end
end
