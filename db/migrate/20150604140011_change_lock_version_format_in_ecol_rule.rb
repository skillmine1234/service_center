class ChangeLockVersionFormatInEcolRule < ActiveRecord::Migration
  def up
    change_column :ecol_rules, :lock_version, :integer
  end
  
  def down
    change_column :ecol_rules, :lock_version, :string
  end 
end
