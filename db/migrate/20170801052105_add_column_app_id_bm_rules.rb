class AddColumnAppIdBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :app_id, :string, limit: 50, comment: 'the app_id for the rule'
  end
end
