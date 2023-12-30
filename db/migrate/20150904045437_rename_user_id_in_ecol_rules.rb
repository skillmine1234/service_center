class RenameUserIdInEcolRules < ActiveRecord::Migration[7.0]
  def change
    rename_column :ecol_rules, :cbs_userid, :customer_id
  end
end
