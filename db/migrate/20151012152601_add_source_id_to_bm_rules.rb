class AddSourceIdToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :source_id, :string, :null => false, :limit => 50, :default => 'qg', :comment => 'the identifier provided by the aggregator to the bank for identification'
  end
end
