class AddUniqueValueToEcolUnapprovedRecords < ActiveRecord::Migration
  def change
    add_column :ecol_unapproved_records, :unique_value, :string
  end
end
