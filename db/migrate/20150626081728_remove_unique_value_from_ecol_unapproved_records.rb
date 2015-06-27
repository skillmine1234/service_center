class RemoveUniqueValueFromEcolUnapprovedRecords < ActiveRecord::Migration
  def change
    remove_column :ecol_unapproved_records, :unique_value
  end
end
