class ChangeNameInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :name, :string, :limit => 60, :null => false
  end
end
