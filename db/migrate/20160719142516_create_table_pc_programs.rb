class CreateTablePcPrograms < ActiveRecord::Migration
  def change
    create_table :pc_programs, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :null => false, :limit => 15, :comment => "the code that identifies the program"
      t.string :mm_host, :null => false, :limit => 255, :comment => "the MatchMove host URI"
      t.string :mm_consumer_key, :null => false, :limit => 255, :comment => "the oauth consumer key shared by MatchMove"
      t.string :mm_consumer_secret, :null => false, :limit => 255, :comment => "the oauth consumer secret shared by MatchMove"
      t.string :mm_card_type, :null => false, :limit => 255, :comment => "the card type, used while registering cards"
      t.string :mm_email_domain, :null => false, :limit => 255, :comment => "the email domain to use, when creating an email address for a user"
      t.string :mm_admin_host, :null => false, :limit => 255, :comment => "the MatchMove Admin host URI"
      t.string :mm_admin_user, :null => false, :limit => 255, :comment => "the username for basic authentication with admin host"
      t.string :mm_admin_password, :null => false, :limit => 255, :comment => "the password for basic authentication with admin host"
      t.string :is_enabled, :null => false, :limit => 1, :comment => "the flag to decide if the account is enabled or not"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
    end
    add_index :pc_programs, [:code, :approval_status], :unique => true, :name => "pc_programs_01"
  end
end
