class IndexOnAdvancedSearchColumnsIc < ActiveRecord::Migration
  def change
    add_index :ic_paynows, [:customer_id, :req_no, :status_code, :attempt_no, :app_id], name: 'IC_PAYNOWS_01'
  end
end
