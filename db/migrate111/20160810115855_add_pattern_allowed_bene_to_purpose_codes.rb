class AddPatternAllowedBeneToPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    remove_column :purpose_codes, :pattern_remitters
    add_column :purpose_codes, :pattern_allowed_benes, :string, :limit => 4000, :comment => "the allowed names in beneficiaries"
  end
end
