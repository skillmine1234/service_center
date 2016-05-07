class CreateFtPurposeCodes < ActiveRecord::Migration
  def change
    create_table :ft_purpose_codes, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 20, :null => false, :comment => "the purpose code"
      t.string :description, :limit => 100, :comment => "the description for this purpose code"
      t.string :is_enabled, :limit => 1, :comment => "the flag which indicates if this purpose code is enabled or not"
      t.string :allow_only_registered_bene, :limit => 1, :comment => "the flag which indicates whether only registered beneficiary is allowed"
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
    add_index :ft_purpose_codes, [:code, :approval_status], :unique => true, :name => "uk_ft_purpose_codes"
  end
end
