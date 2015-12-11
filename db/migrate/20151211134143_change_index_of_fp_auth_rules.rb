class ChangeIndexOfFpAuthRules < ActiveRecord::Migration
  def change
    remove_index :fp_auth_rules, [:username, :operation_name]
    add_index :fp_auth_rules, [:username, :operation_name, :approval_status], :unique => true, :name => 'fp_auth_rules_unique_index'
  end
end
