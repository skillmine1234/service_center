class DropTableEcolUnapprovedRecords < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      db.execute "INSERT INTO unapproved_records (id, approvable_id, approvable_type, created_at, updated_at) 
      SELECT unapproved_records_seq.nextval, ecol_approvable_id, ecol_approvable_type, created_at, updated_at FROM ecol_unapproved_records"
    else
      db.execute "INSERT INTO unapproved_records (approvable_id, approvable_type, created_at, updated_at) 
      SELECT ecol_approvable_id, ecol_approvable_type, created_at, updated_at FROM ecol_unapproved_records"
    end
    drop_table :ecol_unapproved_records
  end
  
  def down

  end
  private

  def db
    ActiveRecord::Base.connection
  end
end
