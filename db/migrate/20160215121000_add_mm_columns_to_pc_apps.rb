class AddMmColumnsToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :mm_host, :string, :limit => 255, :comment => "the MatchMove host URI"
    add_column :pc_apps, :mm_consumer_key, :string, :limit => 255, :comment => "the oauth consumer key shared by MatchMove"
    add_column :pc_apps, :mm_consumer_secret, :string, :limit => 255, :comment => "the outh consumer secret shared by MatchMove"
    add_column :pc_apps, :mm_card_type, :string, :limit => 255, :comment => "the card type, used while reigestering cards"
    add_column :pc_apps, :mm_email_domain, :string, :limit => 255, :comment => "the email domain to use, when creating an email address for a user"
  end
end
