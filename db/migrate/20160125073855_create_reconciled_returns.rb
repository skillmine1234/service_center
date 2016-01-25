class CreateReconciledReturns < ActiveRecord::Migration
  def change
    create_table :reconciled_returns do |t|
      t.string :txn_type, :limit => 10, :null => false, :comment => "Transaction Type"
      t.string :return_code, :limit => 10, :null => false, :comment => "Return Code"
      t.date :settlement_date, :null => false, :comment => "Settlement Date"
      t.string :bank_ref_no, :limit => 32, :null => false, :comment => "Bank Reference No"
      t.string :reason, :limit => 1000, :null => false, :comment => "Reason"
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version, :null => false
      t.string :last_action, :limit => 1
      t.timestamps null: false
    end
  end
end
