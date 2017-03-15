class DropTableInwUnapprovedRecords < ActiveRecord::Migration
  def change
    db.execute "INSERT INTO unapproved_records (approvable_id, approvable_type, created_at, updated_at) 
    SELECT inw_approvable_id, inw_approvable_type, created_at, updated_at FROM inw_unapproved_records"
    drop_table :inw_unapproved_records
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end
