class NewColumnsInEcolRules < ActiveRecord::Migration[7.0]
  def change
    add_column :ecol_rules, :neft_sender_ifsc, :string, :limit => 11
    add_column :ecol_rules, :cbs_userid, :string, :limit => 50
  end
end
