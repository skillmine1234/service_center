class CreatePcApps < ActiveRecord::Migration
  def change
    create_table :pc_apps, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 50, :null => false, :comment =>  "the unique id assigned to a client app"
      t.string :card_acct, :limti => 20, :null => false, :comment =>  "the casa account for recording card transactions"
      t.string :sc_gl_income, :limit => 15, :null => false, :comment =>  "the gl account for recording fee income"
      t.string :is_enabled, :limit => 1, :null => false, :comment =>  "the indicator to denote if the app is allowed access"
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false, :default => 'U'
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.timestamps null: false
      t.index([:app_id, :approval_status], :unique => true)
    end
  end
end
