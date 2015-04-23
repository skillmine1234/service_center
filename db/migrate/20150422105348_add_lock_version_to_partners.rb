class AddLockVersionToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :lock_version, :integer
  end
end
