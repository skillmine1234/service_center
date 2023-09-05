class AddPatternSalutationsToInwRemittanceRules < ActiveRecord::Migration[7.0]
  def change
    add_column :inw_remittance_rules, :pattern_salutations, :string, :limit => 2000
  end
end
