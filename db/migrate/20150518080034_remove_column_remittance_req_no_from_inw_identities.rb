class RemoveColumnRemittanceReqNoFromInwIdentities < ActiveRecord::Migration
  def change
    remove_column :inw_identities, :remittance_req_no
  end
end
