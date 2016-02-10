class CreateInwAuditLogs < ActiveRecord::Migration
  def change
    create_table :inw_audit_logs, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer :inward_remittance_id
      t.text :request_bitstream
      t.text :reply_bitstream
    end
  end
end
