class AddColumnPartialPayToBmBillers < ActiveRecord::Migration
  def change
    add_column :bm_billers, :partial_pay, :string, :limit => 1
  end
end
