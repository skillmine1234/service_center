class CreateEcolAuditLogs < ActiveRecord::Migration
  def change
    create_table :ecol_audit_logs do |t|
      t.integer :ecol_transaction_id, :null => false
      t.string :step_name, :null => false
      t.integer :attempt_no, :null => false
      t.string :fault_code, :limit => 20
      t.string :fault_reason, :limit => 1000
      t.text :req_bitstream, :null => false
      t.text :rep_bitstream
      t.text :fault_bitstream

      t.timestamps null: false
    end

    add_index :ecol_audit_logs, [:step_name,:attempt_no], :unique => true, :name => 'uk_ecolsb_audit_logs1'
  end
end
