class RenameTablePcRegistrations < ActiveRecord::Migration
  def change
    remove_index :pc_registrations, [:req_no, :app_id, :attempt_no]
    rename_table :pc_registrations, :pc_card_registrations
    add_index :pc_card_registrations, [:req_no, :app_id, :attempt_no], :unique => true, :name => "card_reg_unique_constraint"
  end
end
