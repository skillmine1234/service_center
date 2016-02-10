class CreateEcolRemitters < ActiveRecord::Migration
  def change
    create_table :ecol_remitters do |t|
      t.integer :incoming_file_id
      t.string :customer_code, :limit => 15, :null => false
      t.string :customer_subcode, :limit => 15
      t.string :remitter_code, :limit => 28
      t.integer :ecol_customer_id
      t.string :credit_acct_no, :limit => 25
      t.string :customer_subcode_email, :limit => 100
      t.string :customer_subcode_mobile, :limit => 10
      t.string :remitter_name, :limit => 100, :null => false
      t.string :remitter_address, :limit => 105
      t.string :remitter_acct_no, :limit => 25
      t.string :remitter_email, :limit => 100
      t.string :remitter_mobile, :limit => 10
      t.string :invoice_no, :limit => 28
      t.number :invoice_amt
      t.number :invoice_amt_tol_pct
      t.number :min_credit_amt
      t.number :max_credit_amt
      t.datetime :due_date
      t.integer :due_date_tol_days
      t.string :udf1, :limit => 255
      t.string :udf2, :limit => 255
      t.string :udf3, :limit => 255
      t.string :udf4, :limit => 255
      t.string :udf5, :limit => 255
      t.string :udf6, :limit => 255
      t.string :udf7, :limit => 255
      t.string :udf8, :limit => 255
      t.string :udf9, :limit => 255
      t.string :udf10, :limit => 255
      t.string :udf11, :limit => 255
      t.string :udf12, :limit => 255
      t.string :udf13, :limit => 255
      t.string :udf14, :limit => 255
      t.string :udf15, :limit => 255
      t.string :udf16, :limit => 255
      t.string :udf17, :limit => 255
      t.string :udf18, :limit => 255
      t.string :udf19, :limit => 255
      t.string :udf20, :limit => 255
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version, :null => false, :default => 0

      t.timestamps null: false
    end
    
    add_index :ecol_remitters, [:customer_code, :customer_subcode, :remitter_code], :unique => true, :name => :ecol_remitters_unique_index
  end
end
