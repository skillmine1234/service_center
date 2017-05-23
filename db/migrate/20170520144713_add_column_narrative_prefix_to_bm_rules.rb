class AddColumnNarrativePrefixToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :narrative_prefix, :string, :limit => 50, :comment => "the narrative value which will used in fcr request"    
    add_column :bm_rules, :user_id, :string, :limit => 50, :comment => "the userID of the flex API"    
  end
end
