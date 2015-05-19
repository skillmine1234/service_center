class ChangeColumnLockVersionToPartners < ActiveRecord::Migration
  def change
    change_column :partners, :lock_version, :integer, :default => 0, :null => false
  end
end
