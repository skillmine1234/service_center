class ChangeIndexOnPcCustomers < ActiveRecord::Migration
  def change
    remove_index :pc_customers, [:card_uid, :card_no]
    remove_index :pc_customers, :name => 'pc_customers_unique_constraint'
    add_index :pc_customers, :card_uid, :unique => true
    add_index :pc_customers, :card_no, :unique => true
    add_index :pc_customers, :email_id, :unique => true
    add_index :pc_customers, :doc_no, :unique => true
    add_index :pc_customers, :proxy_card_no, :unique => true
  end
end
