class RenameRulesToInwRemittanceRules < ActiveRecord::Migration
  def change
    rename_table :rules, :inw_remittance_rules
  end
end
