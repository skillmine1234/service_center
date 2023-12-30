class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :ifsc
      t.string :name
      t.boolean :imps_enabled

      t.timestamps null: false
    end
  end
end
