class AddColumnsToRcApps < ActiveRecord::Migration
  def change
    add_column :rc_apps, :url, :string, limit: 100, comment: 'the URL for the app'
    RcApp.unscoped.update_all(url: 'http://localhost')
    change_column :rc_apps, :url, :string, null: false
    add_column :rc_apps, :http_username, :string, limit: 50, comment: 'the http_username for the app'
    add_column :rc_apps, :http_password, :string, limit: 50, comment: 'the http_password for the app'
    add_column :rc_apps, :setting1, :string, comment: 'the setting 1 for the app'
    add_column :rc_apps, :setting2, :string, comment: 'the setting 2 for the app'
    add_column :rc_apps, :settings_cnt, :integer, null: false, default: 0, comment: 'the number of settings for the app'
  end
end
