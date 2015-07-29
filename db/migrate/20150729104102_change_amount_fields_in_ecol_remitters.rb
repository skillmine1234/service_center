class ChangeAmountFieldsInEcolRemitters < ActiveRecord::Migration
  def change
    change_column :ecol_remitters, :invoice_amt, :float, :scale => 2
    change_column :ecol_remitters, :min_credit_amt, :float, :scale => 2
    change_column :ecol_remitters, :max_credit_amt, :float, :scale => 2
  end
end
