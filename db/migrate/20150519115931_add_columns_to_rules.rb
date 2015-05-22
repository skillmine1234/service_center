class AddColumnsToRules < ActiveRecord::Migration
  def change
    add_column :rules, :created_by, :string
    add_column :rules, :updated_by, :string
    add_column :rules, :lock_version, :integer, :default => 0, :null => false
  end
end
