class ChangeReturnAttemptNoToLong < ActiveRecord::Migration
  def change
    change_column :ecol_transactions, :return_attempt_no, :integer, :limit => 8
  end
end
