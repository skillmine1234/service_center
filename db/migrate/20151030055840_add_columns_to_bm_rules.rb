class AddColumnsToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :traceid_prefix, :integer, :null => false, :default => "Q"
  end
end
