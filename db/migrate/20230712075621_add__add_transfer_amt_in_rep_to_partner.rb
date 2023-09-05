class AddAddTransferAmtInRepToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :add_transfer_amt_in_rep, :string
  end
end
