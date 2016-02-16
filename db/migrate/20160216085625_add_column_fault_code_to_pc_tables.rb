class AddColumnFaultCodeToPcTables < ActiveRecord::Migration
  def change
    tables = ["pc_audit_logs", "pc_audit_steps", "pc_load_cards", "pc_block_cards", "pc_card_registrations"]
    tables.each do |table|
      add_column table.to_s, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"
    end
  end
end
