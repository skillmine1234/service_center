class AddColumnNarrativePrefixToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :narrative_prefix, :string, :limit => 50, :comment => "the narrative value which will used in fcr request"    
  end
end
