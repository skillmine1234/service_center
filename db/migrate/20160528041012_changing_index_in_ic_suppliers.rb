class ChangingIndexInIcSuppliers < ActiveRecord::Migration
  def change
    remove_index :ic_suppliers, :name => 'i_ic_supp_code'
    add_index "ic_suppliers", ["supplier_code","customer_id","corp_customer_id","approval_status"], name: "ic_suppliers_01", unique: true
  end
end
