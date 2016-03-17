class CreateSalaryDetails < ActiveRecord::Migration
  def change
    create_table :salary_details do |t|
      t.string :source_account_no, :limit => 15, :null => false, :comment => "the Account Number of Corporate"
      t.string :source_reference_no, :limit => 15, :null => false, :comment => "the Employer payment reference no"
      t.string :source_narration, :limit => 40, :null => false, :comment => "the Narration to go in Empaloyer statement"
      t.string :destination_account_number, :limit => 15, :null => false, :comment => "the Account Number of Employe"
      t.string :destination_name, :limit => 35, :comment => "the Account Name of Employe"
      t.string :destination_reference_no, :limit => 12, :comment => "the Employee Reference No"
      t.number :transfer_amount, :comment => "the Salary Amount"
      t.string :destination_narration, :limit => 40, :comment => "the Narration to go in Employee statement"
      t.string :bank_reference_no, :limit => 40, :comment => "the Bank reference number generated by ESB"
      t.string :debit_reference_no, :limit => 40, :comment => "the Debit Reference No returned by FCR FT API while debiting the Employer account"
      t.string :credit_reference_no, :limit => 40,:comment => "the Credit Reference No returned by FCR FT API while crediting Employee account"
      t.datetime :settled_at, :comment => "the SYSDATE when Settlement Date Time"
      t.string :settlement_account_no, :limit => 15, :comment => "the Bank Pool Account from where final payment is made to the employee"
      t.string :status, :limit => 15, :comment => "the status of the transaction"
      t.string :fault_code, :limit => 50, :comment => "the code that identifies the business failure reason/exception"
      t.string :fault_reason, :limit => 1000, :comment => "the english reason of the business failure reason/exception"     
    end
  end
end