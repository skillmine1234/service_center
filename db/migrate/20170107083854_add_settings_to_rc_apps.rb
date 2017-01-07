class AddSettingsToRcApps < ActiveRecord::Migration
  def change
    add_column :rc_apps, :setting3, :string, comment: 'the setting 3 for the app'
    add_column :rc_apps, :setting4, :string, comment: 'the setting 4 for the app'
    add_column :rc_apps, :setting5, :string, comment: 'the setting 5 for the app'
  end
end
