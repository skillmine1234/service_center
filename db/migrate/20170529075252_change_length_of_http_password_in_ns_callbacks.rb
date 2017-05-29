class ChangeLengthOfHttpPasswordInNsCallbacks < ActiveRecord::Migration
  def change
    change_column :ns_callbacks, :http_password, :string, limit: 255
  end
end
