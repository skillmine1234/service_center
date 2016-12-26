class AddIndexOnBmBillers < ActiveRecord::Migration
  def change
    add_index :bm_billers, [:biller_category, :biller_location, :approval_status, :is_enabled], :unique => false, :name => "bm_billers_01"
    add_index :bm_billers, [:biller_location, :approval_status, :is_enabled], :unique => false, :name => "bm_billers_02" 
  end
end
