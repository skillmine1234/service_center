class ChangesInFpAuthRules < ActiveRecord::Migration
  def change
    change_column :fp_auth_rules, :is_enabled, :string, :limit => 1, :null => false, :default => 'N', :comment => "the indicator to denote whether the access is enabled"
    change_column :fp_auth_rules, :any_source_ip, :string, :limit => 1, :null => false, :default => 'N', :comment => "this field indicates whether any ip address is acceptable or not"
    remove_index :fp_auth_rules, :name => 'uk_fp_auth_rules'
    add_index :fp_auth_rules, [:username, :approval_status], :unique => true, :name => 'uk_fp_auth_rules'
    change_column :fp_auth_rules, :operation_name, :string, :limit => 4000, :null => false, :comment =>  "the operation to which access is granted"
    change_column :fp_auth_rules, :source_ips, :string, :limit => 4000, :null => false, :comment =>  "the list of ip-address(s) from which connections are accepted for the user"
  end
end
