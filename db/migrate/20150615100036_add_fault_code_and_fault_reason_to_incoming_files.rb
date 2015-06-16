class AddFaultCodeAndFaultReasonToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :fault_code, :string, :limit => 50
    add_column :incoming_files, :fault_reason, :string, :limit => 500
  end
end
