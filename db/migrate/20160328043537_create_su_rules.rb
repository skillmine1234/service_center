class CreateSuRules < ActiveRecord::Migration
  def change
    create_table :su_rules do |t|
      t.string :pool_account_no, :limit => 20, :null => false, :comment =>"the bank pool acocunt no"
      t.string :customer_id, :limit => 15, :null => false, :comment => "customer id"
      t.integer :threshold_percentage, :comment =>"the threshold percentage for matching names"
      t.string :created_by, :limit => 20, :null => false, :comment =>"the person who creates the record"
      t.string :updated_by, :limit => 20, :null => true, :comment =>"the person who updates the record"
      t.datetime :created_at, :null => true, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => true, :comment =>"the timestamp when the record was last updated"
      t.integer :lock_version,  :null => true, :comment =>"the version number of the record, every update increments this by 1"
      t.string :approval_status, :limit => 1, :null => true, :comment => "the indicator to denote whether this record is pending approval or is approved"
      t.string :last_action, :limit => 1, :null => true, :comment => "the last action (create, update) that was performed on the record"
      t.integer :approved_version,  :null => true, :comment => "the version number of the record, at the time it was approved"
      t.integer :approved_id,  :null => true, :comment => "the id of the record that is being updated"
    end
  end
end
