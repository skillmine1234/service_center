class RenameColumnsInPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    rename_column :purpose_codes, :disallowedremtypes, :disallowed_rem_types
    rename_column :purpose_codes, :disallowedbenetypes, :disallowed_bene_types
  end
end
