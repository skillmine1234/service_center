class AddColumnsToPcCardRegistrations < ActiveRecord::Migration
  def change
    add_column :pc_card_registrations, :cust_uid, :string, :limit => 255, :comment => "the unique ID assigned to the user"
    add_column :pc_card_registrations, :card_uid, :string, :limit => 255, :comment => "the unique ID assigned to the card"
    add_column :pc_card_registrations, :card_no, :string, :limit => 255, :comment => "the card number allocated to the customer"
    add_column :pc_card_registrations, :card_issue_date, :datetime, :comment => "the issue date of the card"
    add_column :pc_card_registrations, :card_expiry_year, :int,  :comment => "the expiry year of the card "
    add_column :pc_card_registrations, :card_expiry_month, :int,  :comment => "the expiry month of the card"
    add_column :pc_card_registrations, :card_holder_name, :string, :limit => 255, :comment => "the name of the customer"
    add_column :pc_card_registrations, :card_type, :string, :limit => 255, :comment => "the nature of the card"
    add_column :pc_card_registrations, :card_name, :string, :limit => 255, :comment => "the short name of the card"
    add_column :pc_card_registrations, :card_desc, :string, :limit => 255, :comment => "the long name of the card"
    add_column :pc_card_registrations, :card_image_small_uri, :string, :limit => 255, :comment => "the card image (small) for use by systems"
    add_column :pc_card_registrations, :card_image_medium_uri, :string, :limit => 255, :comment => "the card image (medium) for use by systems"
    add_column :pc_card_registrations, :card_image_large_uri, :string, :limit => 255, :comment => "the card image (large) for use by systems"
      end
  end