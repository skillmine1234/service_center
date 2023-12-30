class AddColumnsToBmRules < ActiveRecord::Migration[7.0]
  def change
    add_column :bm_rules, :traceid_prefix, :integer, :null => false, :default => 1
  end
end
