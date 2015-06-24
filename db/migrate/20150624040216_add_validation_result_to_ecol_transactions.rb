class AddValidationResultToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :validation_result, :string, :limit => 1000
  end
end
