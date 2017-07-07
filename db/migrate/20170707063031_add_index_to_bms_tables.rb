class AddIndexToBmsTables < ActiveRecord::Migration
  def change
    add_index :bm_add_auto_pays, [:customer_id, :req_no, :status_code, :biller_code, :req_timestamp, :rep_timestamp], :name => 'bm_add_auto_pays_02'
    add_index :bm_delete_auto_pays, [:customer_id, :req_no, :status_code, :biller_code, :req_timestamp, :rep_timestamp], :name => 'bm_delete_auto_pays_02'
    add_index :bm_modify_auto_pays, [:customer_id, :req_no, :status_code, :biller_code, :req_timestamp, :rep_timestamp], :name => 'bm_modify_auto_pays_02'
    add_index :bm_set_auto_pays, [:customer_id, :req_no, :status_code, :biller_code, :req_timestamp, :rep_timestamp], :name => 'bm_set_auto_pays_02'
  end
end
