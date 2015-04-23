class RenameColumnsInPurposeCodes < ActiveRecord::Migration
  def change
    rename_column :purpose_codes, :disallowedremtypes, :disallowed_rem_types
    rename_column :purpose_codes, :disallowedbenetypes, :disallowed_bene_types
  end
end
