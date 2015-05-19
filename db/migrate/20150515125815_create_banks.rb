class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.string :ifsc
      t.string :name
      t.boolean :imps_enabled

      t.timestamps null: false
    end
  end
end
