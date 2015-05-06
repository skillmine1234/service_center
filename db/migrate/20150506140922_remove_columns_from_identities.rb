class RemoveColumnsFromIdentities < ActiveRecord::Migration
  def change
    remove_column :identities, :is_verified, :verified_at, :verified_by
  end
end
