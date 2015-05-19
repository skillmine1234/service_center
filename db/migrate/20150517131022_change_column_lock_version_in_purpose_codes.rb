class ChangeColumnLockVersionInPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :lock_version, :integer, :default => 0, :null => false
  end
end
