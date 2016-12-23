class AddIndex1BmBillers < ActiveRecord::Migration
  def change
    add_index :bm_billers, [:biller_category, :biller_location, :approval_status, :is_enabled], :unique => false, :name => "biller_category_bm_billers"
    add_index :bm_billers, [:biller_location, :approval_status, :is_enabled], :unique => false, :name => "biller_location_bm_billers" 
  end
end
