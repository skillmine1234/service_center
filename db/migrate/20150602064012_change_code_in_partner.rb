class ChangeCodeInPartner < ActiveRecord::Migration
  def change
    change_column :partners, :code, :string, :limit => 4
  end
end
