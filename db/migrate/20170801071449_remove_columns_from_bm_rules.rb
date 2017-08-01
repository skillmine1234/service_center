class RemoveColumnsFromBmRules < ActiveRecord::Migration
  def change
    remove_column :bm_rules, :service_id, :string
    remove_column :bm_rules, :narrative_prefix, :string
    remove_column :bm_rules, :user_id, :string
    remove_column :bm_rules, :source_id, :string
    remove_column :bm_rules, :traceid_prefix, :string
  end
end
