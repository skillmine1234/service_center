class RenameRulesToInwRemittanceRules < ActiveRecord::Migration[7.0]
  def change
    rename_table :rules, :inw_remittance_rules
  end
end
