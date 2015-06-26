class MakeRmtrFullNameNotNullInEcolTransaction < ActiveRecord::Migration
  def change
    change_column :ecol_transactions, :rmtr_full_name, :string, null: false
  end
end
