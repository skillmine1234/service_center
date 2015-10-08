class ChangeFieldLimitsInBmBillers < ActiveRecord::Migration
  def change
    change_column :bm_billers, :processing_method, :string, :limit => 1
    change_column :bm_billers, :param1_tooltip, :string, :limit => 255
    change_column :bm_billers, :param2_tooltip, :string, :limit => 255
    change_column :bm_billers, :param3_tooltip, :string, :limit => 255
    change_column :bm_billers, :param4_tooltip, :string, :limit => 255
    change_column :bm_billers, :param5_tooltip, :string, :limit => 255
  end
end
