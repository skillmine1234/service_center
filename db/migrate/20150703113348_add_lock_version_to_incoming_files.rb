class AddLockVersionToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :lock_version, :integer
  end
end
