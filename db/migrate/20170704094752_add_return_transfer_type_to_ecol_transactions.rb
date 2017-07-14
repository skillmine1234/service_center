class AddReturnTransferTypeToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :return_transfer_type, :string, limit: 10, comment: 'the transfer_type by which the return for this transaction took place'
  end
end
