class CreateSalaryPayments < ActiveRecord::Migration
  def change
    create_table :salary_payments do |t|
      t.string :source_account_no, :limit => 15, :null => false, :comment => "the Corporate Account Number for the record"
      t.string :bank_pool_account_no, :limit => 25, :null => false, :comment => "the Bank Pool Account which has been cdebited"
      t.number :transfer_amount, :null => false, :comment => "the Total amount debited to corporate account towards salary payment"
      t.datetime :debited_at, :comment => "the SYSDATE when the Corporate Pool Account debit date and time"
      t.string :bank_reference_no, :limit => 40, :comment => "ESB generated reference no passed to FCR FT"
      t.string :debit_reference_no, :limit => 40, :comment => "Debit Reference No returned by FCR FT"
      t.integer :payment_attempt_no, :comment => "No of attempts for debitig the Pool Account"
      t.string :status, :limit => 20, :null => false, :comment => "Possible values NEW,DEBITED, FAILED,PENDING_REVERSAL,REVERSED"
      t.datetime :reversed_at, :comment => "the SYSDATE when Corporate Pool Account debit date and time"
      t.string :reversal_reference_no, :limit => 40, :comment => "Debit Reference No returned by FCR FT"
    end
  end
end