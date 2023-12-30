class AddDefaultValueToColumnsInBmRules < ActiveRecord::Migration[7.0]
  def change
    change_column :bm_rules, :approval_status , :string, :default => 'A'
    change_column :bm_rules, :last_action , :string, :default => 'C'
  end
end
