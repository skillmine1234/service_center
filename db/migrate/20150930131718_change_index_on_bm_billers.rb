class ChangeIndexOnBmBillers < ActiveRecord::Migration
  def change
    add_index :bm_billers, [:biller_code, :approval_status], :unique => true
    remove_index :bm_billers, :biller_code
  end
end
