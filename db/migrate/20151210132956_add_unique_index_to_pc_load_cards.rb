class AddUniqueIndexToPcLoadCards < ActiveRecord::Migration
  def change
    rename_table :load_cards, :pc_load_cards
    add_index :pc_load_cards, [:req_no, :app_id, :attempt_no], :unique => true
  end
end
