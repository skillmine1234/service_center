class AddColumnAllowReturnByRtgsToEcolRules < ActiveRecord::Migration
  def change
    add_column :ecol_rules, :allow_return_by_rtgs, :string, null: false, default: 'N', comment: 'the flag which indicates whether return is allowed by RTGS or not'
  end
end
