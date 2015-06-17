class AddColumnLockVersionInUdfAttributes < ActiveRecord::Migration
  def change
    add_column :udf_attributes, :lock_version, :integer, :default => 0, :null => false
  end
end
