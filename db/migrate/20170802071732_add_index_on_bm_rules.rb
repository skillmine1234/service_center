class AddIndexOnBmRules < ActiveRecord::Migration[7.0]
  def change
    add_index :bm_rules, [:app_id, :approval_status], unique: true, name: 'bm_rules_01'
  end
end
