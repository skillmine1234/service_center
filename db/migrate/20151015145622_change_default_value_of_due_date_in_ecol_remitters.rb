class ChangeDefaultValueOfDueDateInEcolRemitters < ActiveRecord::Migration
  def change
    change_column :ecol_remitters, :due_date, :date, :default => "2015-01-01"
  end
end
