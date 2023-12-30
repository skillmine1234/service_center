class AddColumnAnySourceIpToFpAuthRules < ActiveRecord::Migration[7.0]
  def change
    add_column :fp_auth_rules, :any_source_ip, :string, :limit => 1, :comment => "this field indicates whether any ip address is acceptable or not"
  end
end
