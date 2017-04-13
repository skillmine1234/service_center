class DropTableScUnapprovedRecords < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      db.execute "INSERT INTO unapproved_records (id, approvable_id, approvable_type, created_at, updated_at) 
      SELECT unapproved_records_seq.nextval, sc_approvable_id, sc_approvable_type, created_at, updated_at FROM sc_unapproved_records"
    else
      db.execute "INSERT INTO unapproved_records (approvable_id, approvable_type, created_at, updated_at) 
      SELECT sc_approvable_id, sc_approvable_type, created_at, updated_at FROM sc_unapproved_records"
    end
    drop_table :sc_unapproved_records
  end
  
  def down

  end
  private

  def db
    ActiveRecord::Base.connection
  end
end
