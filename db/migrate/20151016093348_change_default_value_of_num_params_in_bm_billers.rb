class ChangeDefaultValueOfNumParamsInBmBillers < ActiveRecord::Migration
  def change
    change_column :bm_billers, :num_params, :integer, :default => 0
  end
end
