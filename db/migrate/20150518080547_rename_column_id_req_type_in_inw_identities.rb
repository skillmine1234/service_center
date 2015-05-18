class RenameColumnIdReqTypeInInwIdentities < ActiveRecord::Migration
  def change
    rename_column :inw_identities, :id_req_type, :id_for
  end
end
