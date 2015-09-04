class RenameUserIdInEcolRules < ActiveRecord::Migration
  def change
    rename_column :ecol_rules, :cbs_userid, :customer_id
  end
end
