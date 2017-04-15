class DropTableInwUnapprovedRecords < ActiveRecord::Migration
  def change
    db.execute "insert into unapproved_records select * from inw_unapproved_records"
    drop_table :inw_unapproved_records
  end
  
  private

  def db
    ActiveRecord::Base.connection
  end
end
