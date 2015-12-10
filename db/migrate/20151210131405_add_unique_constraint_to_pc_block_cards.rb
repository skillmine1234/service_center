class AddUniqueConstraintToPcBlockCards < ActiveRecord::Migration
  def change
    add_index :pc_block_cards, [:req_no, :app_id, :attempt_no], :unique => true
  end
end
