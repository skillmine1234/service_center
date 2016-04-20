class CreateFtCustomers < ActiveRecord::Migration
  def change
    create_table :ft_customers, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 20, :null => false, :comment => "the unique id assigned to a client app"
      t.string :name, :limit => 100, :null => false, :comment => "the name of the customers"
      t.integer :low_balance_alert_at, :null => false, :comment => "the amount for low balance alert"
      t.string :identity_user_id, :null => false, :comment => "the user ID of Customer"
      t.string :allow_neft, :limit => 1, :null => false, :comment => "the flag to indicate if NEFT is allowed for this customer"
      t.string :allow_imps, :limit => 1, :null => false, :comment => "the flag to indicate if IMPS is allowed for this customer"
      t.string :allow_rtgs, :string, :limit => 1, :comment => "the flag to identify whether rtgs is allowed for the app_id or not"
      t.string :enabled, :limit => 1, :null => false, :default => 'N', :comment => "the flag to indicate if customer is enabled"
      t.string :is_retail, :limit => 1, :comment => "the flag to identify whether app_id is for retail or corporate customer"
      t.string :customer_id, :string, :limit => 15, :null => true, :comment => "the ID of the customer"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :default => 'U', :null => false, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :default => 'C', :null => false, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id, :comment => "the id of the record that is being updated"
    end
    add_index :ft_customers, :name, :name => "in_ft_customers_1"
    add_index :ft_customers, [:app_id, :customer_id, :approval_status], :unique => true, :name => "in_ft_customers_2"
  end
end
