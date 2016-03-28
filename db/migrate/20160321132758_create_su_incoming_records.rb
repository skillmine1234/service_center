class CreateSuIncomingRecords < ActiveRecord::Migration
  def change
    create_table :su_incoming_records do |t|
       t.integer :incoming_file_record_id, :comment => "the foreign key to the incoming_files table" 
       t.string  :file_name, :comment => "the name of the incoming_file"      
       t.string  :corp_acct_no, :comment => "the employers account no, repeates for every record, and is validated to be the same for all"
       t.string  :corp_ref_no, :comment => "the ref no for the single debit that is done to the employers account"
       t.string  :corp_stmt_txt, :comment => "the text for the single debit that is done to the employers account"
       t.string  :emp_acct_no, :comment => "the employees account no, can repeat in the file"
       t.string  :emp_name, :comment => "the employees name, this is used as check and prevent incorrect credits"
       t.string  :emp_ref_no, :comment => "the employee reference no"
       t.number  :sal_amount, :comment => "the employees salary"
       t.string  :emp_stmt_txt, :comment => "the text for the single debit that is done to the employees account"
       t.string  :account_name, :comment => "the name of the account,we will get ot based on account no from fcr this is used as check and prevent incorrect credits"
       t.number  :distance_in_name, :comment => "the distance between the emp_name and account_name, 100 indiciating complete match"
       t.index([:incoming_file_record_id], :unique => false, :name => 'su_incoming_records_1')
       t.index([:file_name], :unique => false, :name => 'su_incoming_records_2')
    end
  end
end
