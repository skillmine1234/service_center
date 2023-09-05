class AddAddReqRefInRepToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :add_req_ref_in_rep, :string
  end
end
