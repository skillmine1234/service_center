class ChangeNullConstraintOfAppCode < ActiveRecord::Migration
  def change
    change_column :ecol_customers, :app_code, :string, :limit => 15, :null => true, :comment => "the unique code of the application"
  end
end
