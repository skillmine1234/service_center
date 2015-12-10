class CreatePcApps < ActiveRecord::Migration
  def change
    create_table :pc_apps do |t|
      t.string :app_id, :limit => 50, :null => false
      t.string :card_acct, :limti => 20, :null => false
      t.string :sc_gl_income, :limit => 15, :null => false
      t.string :is_enabled, :limit => 1
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
    end
    add_index :pc_apps, [:app_id, :approval_status], :unique => true
  end
end
