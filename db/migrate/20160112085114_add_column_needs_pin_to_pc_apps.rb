class AddColumnNeedsPinToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :needs_pin, :string, :limit => 1, :comment => 'the flag to indicate whether the provided pin has to be validated or not'
    db.execute "UPDATE pc_apps SET needs_pin = 'N'"
    change_column :pc_apps, :needs_pin, :string, :limit => 1, :default => 'N', :null => false, :comment => 'the flag to indicate whether the provided pin has to be validated or not'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
