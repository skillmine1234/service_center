class ChangeLengthOfHttpPasswordInEcApps < ActiveRecord::Migration
  def change
    change_column :ecol_apps, :http_password, :string, limit: 255, comment: 'the http_password for the app'
  end
end
