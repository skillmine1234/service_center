class AddColumnValidationRefToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :validation_ref, :string, :limit => 50, :comment => "the unique number which is returned by the validationService"
  end
end
