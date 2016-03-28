class AddDbUnitNameToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types, :db_unit_name, :string,  :comment => "the name of the database unit (package or procedure) that is to be called to validate the (all records)"
    add_column :incoming_file_types, :records_table, :string,  :comment => "the name of the table where the records would be kept, the column names should be the same as defined in the model"
  end
end
