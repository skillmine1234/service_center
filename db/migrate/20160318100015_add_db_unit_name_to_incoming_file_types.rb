class AddDbUnitNameToIncomingFileTypes < ActiveRecord::Migration
  def change
    add_column :incoming_file_types , :db_unit_name, :string, :limit => 255, :comment => "the name of the database unit (package or procedure) that is to be called to validate the (all records)"
  end
end
