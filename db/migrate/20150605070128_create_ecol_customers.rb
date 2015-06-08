class CreateEcolCustomers < ActiveRecord::Migration
  def change
    create_table :ecol_customers do |t|
      t.string :code, :limit => 11, :null => false
      t.string :name, :limit => 15, :null => false
      t.string :is_enabled, :limit => 15, :default => 'TRUE', :null => false
      t.string :val_method, :limit => 1, :null => false
      t.string :token_1_type, :limit => 3, :default => 'N', :null => false
      t.integer :token_1_length, :default => 0, :null => false
      t.string :val_token_1, :limit => 1, :null => false
      t.string :token_2_type, :limit => 3, :default => 'N', :null => false
      t.integer :token_2_length, :default => 0, :null => false
      t.string :val_token_2, :limit => 1, :default => 'N', :null => false
      t.string :token_3_type, :limit => 3, :null => false
      t.integer :token_3_length, :default => 0, :null => false
      t.string :val_token_3, :limit => 1, :default => 'N', :null => false
      t.string :val_txn_date, :limit => 1, :default => 'N', :null => false
      t.string :val_txn_amt, :limit => 1, :default => 'N', :null => false
      t.string :val_ben_name, :limit => 1, :default => 'N', :null => false
      t.string :val_rem_acct, :limit => 1, :default => 'N', :null => false
      t.string :return_if_val_fails, :limit => 1, :default => 'N', :null => false
      t.string :file_upld_mthd, :limit => 1
      t.string :credit_acct_no, :limit => 25, :null => false
      t.string :nrtv_sufx_1, :limit => 3, :default => 'N', :null => false
      t.string :nrtv_sufx_2, :limit => 3, :default => 'N', :null => false
      t.string :nrtv_sufx_3, :limit => 3, :default => 'N', :null => false
      t.string :rmtr_alert_on, :limit => 1, :default => 'N', :null => false
      t.string :rmtr_pass_txt, :limit => 500
      t.string :rmtr_return_txt, :limit => 500
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version, :null => false, :default => 0

      t.timestamps null: false
    end
    
    add_index :ecol_customers, [:code], :unique => true, :name => :code_unique_index
  end
end
