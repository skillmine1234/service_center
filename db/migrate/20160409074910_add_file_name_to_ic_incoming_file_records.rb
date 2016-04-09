class AddFileNameToIcIncomingFileRecords < ActiveRecord::Migration
  def change
    add_column :ic_incoming_records, :file_name, :string, :limit=> 50, :comment => "the name of the incoming_file" 
    db.execute "UPDATE ic_incoming_records SET file_name = 'a'"
    change_column :ic_incoming_records, :file_name, :string, :null => false, :limit=> 50, :comment => "the name of the incoming_file" 
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
