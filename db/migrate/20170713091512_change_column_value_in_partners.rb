class ChangeColumnValueInPartners < ActiveRecord::Migration
  def change
    db.execute "update partners set auto_reschdl_to_next_wrk_day = 'N' where service_name = 'INW'"
  end
  def db
    ActiveRecord::Base.connection
  end  
end
