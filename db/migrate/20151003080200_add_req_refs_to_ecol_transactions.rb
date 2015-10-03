class AddReqRefsToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :return_req_ref, :string, :limit => 64
    add_column :ecol_transactions, :settle_req_ref, :string, :limit => 64
    add_column :ecol_transactions, :credit_req_ref, :string, :limit => 64
  end
end
