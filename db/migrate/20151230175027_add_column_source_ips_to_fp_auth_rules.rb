class AddColumnSourceIpsToFpAuthRules < ActiveRecord::Migration
  def change
    add_column :fp_auth_rules, :source_ips, :string, :limit => 2000, :comment => 'the list of ip-address(s) from which connections are accepted for the user'
  end
end
