class AddPatternRemittersToInwRemittanceRules < ActiveRecord::Migration[7.0]
  def change
    add_column :inw_remittance_rules, :pattern_remitters, :string, :limit => 4000
  end
end
