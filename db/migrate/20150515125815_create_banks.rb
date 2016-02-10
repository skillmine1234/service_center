class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :ifsc
      t.string :name
      t.boolean :imps_enabled

      t.timestamps null: false
    end
  end
end
