class AddIndexToEcolRemitters < ActiveRecord::Migration
  def change
    remove_index :ecol_remitters, :name => :ecol_remitters_unique_index
    add_index :ecol_remitters, [:customer_code, :customer_subcode, :remitter_code, :invoice_no], :unique => true, :name => 'ecol_remitters_unique_index'
  end
end
