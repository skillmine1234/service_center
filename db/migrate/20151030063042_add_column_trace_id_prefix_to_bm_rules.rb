class AddColumnTraceIdPrefixToBmRules < ActiveRecord::Migration
  def change
    change_column :bm_rules, :traceid_prefix, :integer, :null => false, :default => 1, :comment => 'for generating unique requestNo for calling billdesk'
  end
end
