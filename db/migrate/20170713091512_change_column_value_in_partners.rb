class ChangeColumnValueInPartners < ActiveRecord::Migration
  def change
    Partner.where("service_name =?","INW").update_all(auto_reschdl_to_next_wrk_day: 'N')
  end 
end
