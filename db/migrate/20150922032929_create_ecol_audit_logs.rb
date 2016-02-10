class CreateEcolAuditLogs < ActiveRecord::Migration
  def change
    create_table :ecol_audit_logs, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :ecol_transaction_id, :null => false
      t.string :step_name, :null => false
      t.integer :attempt_no, :null => false
      t.string :fault_code, :limit => 50
      t.string :fault_reason, :limit => 1000
      t.date :req_timestamp
      t.date :rep_timestamp
      t.text :req_bitstream
      t.text :rep_bitstream
      t.text :fault_bitstream

      t.timestamps null: false
    end

    add_index :ecol_audit_logs, [:ecol_transaction_id,:step_name,:attempt_no], :unique => true, :name => 'uk_ecol_audit_logs'
  end
end

