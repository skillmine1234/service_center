class AddColumnToEcolRules < ActiveRecord::Migration
  def change
    add_column :ecol_rules, :return_account_no, :string, :limit => 20, :comment => "the common return account for imps, since remitter detail is not present in the incoming credit"
  end
end
