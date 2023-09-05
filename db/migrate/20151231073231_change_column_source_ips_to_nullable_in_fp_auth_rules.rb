class ChangeColumnSourceIpsToNullableInFpAuthRules < ActiveRecord::Migration[7.0]
  def change
    change_column :fp_auth_rules, :source_ips, :string, :limit => 4000, :null => true, :comment =>  "the list of ip-address(s) from which connections are accepted for the user"
  end
end
