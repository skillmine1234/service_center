class RenameIdentitiesToInwIdentities < ActiveRecord::Migration
  def change
    rename_table :identities, :inw_identities
  end
end
