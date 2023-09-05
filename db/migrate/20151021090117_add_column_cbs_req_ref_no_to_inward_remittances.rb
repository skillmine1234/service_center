class AddColumnCbsReqRefNoToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :cbs_req_ref_no, :string
  end
end
