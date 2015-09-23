class AddValidateAttemptNoToEcolTransactions < ActiveRecord::Migration
  def change
    add_column :ecol_transactions, :validate_attempt_no, :integer
  end
end
