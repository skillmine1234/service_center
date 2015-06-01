class AddPatternBeneficiariesToPurposeCodes < ActiveRecord::Migration
  def change
    add_column :purpose_codes, :pattern_beneficiaries, :string, :limit => 4000
  end
end
