class ChangeIndexOfFpOperations < ActiveRecord::Migration
  def change
    remove_index :fp_operations, :operation_name
    add_index :fp_operations, [:operation_name, :approval_status], :unique => true
  end
end
