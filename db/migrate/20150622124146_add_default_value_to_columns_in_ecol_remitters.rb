class AddDefaultValueToColumnsInEcolRemitters < ActiveRecord::Migration
  def change
    change_column :ecol_remitters, :due_date_tol_days, :integer, :default => 0
    change_column :ecol_remitters, :invoice_amt, :number, null: false
    change_column :ecol_remitters, :due_date, :date, null: false, :default => '1950-01-01'
  end
end
