class AddNotNullConstraintToColumnsInEcolRules < ActiveRecord::Migration[7.0]
  def change
    change_column :ecol_rules, :neft_sender_ifsc, :string, :null => false
    change_column :ecol_rules, :cbs_userid, :string, :null => false
  end
end
