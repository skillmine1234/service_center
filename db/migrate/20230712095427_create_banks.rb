class CreateBanks < ActiveRecord::Migration[7.0]
  def change
    create_table :banks do |t|
      t.string :ifsc
      t.string :name
      t.boolean :imps_enabled

      t.timestamps
    end
  end
end
