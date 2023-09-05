class CreatePurposeCodes < ActiveRecord::Migration[7.0]
  def change
    create_table :purpose_codes do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 5
      t.string :description, :limit => 200
      t.string :is_enabled, :limit => 1
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.integer :lock_version
      t.integer :txn_limit
      t.integer :daily_txn_limit
      t.string :disallowedremtypes, :limit => 30
      t.string :disallowedbenetypes, :limit => 30

      t.timestamps
    end
  end
end
