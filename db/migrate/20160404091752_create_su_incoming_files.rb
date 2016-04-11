class CreateSuIncomingFiles < ActiveRecord::Migration
  def change
    create_table :su_incoming_files do |t|
       t.string  :file_name, :limit => 50, :comment => "the name of the incoming_file"    
       t.number  :debit_amount, :comment => "the value of the consolidated debit to the corporates accuont"
       t.string  :debit_reference_no, :limit => 64, :comment => "the reference number for consolidated debit to the corporate account" 
       t.string  :debit_status, :limit => 20, :comment =>"the status of the consolidated debit to the corporates account"
       t.datetime :debited_at,  :comment => "the timestamp when the consolidated debit completed" 
       t.number  :reversal_amount,  :comment => "the value of the amount that is credited back to the corporates account"  
       t.string  :reversal_reference_no, :limit => 64, :comment => "the reference number for credit back to the corporate account"    
       t.string  :reversal_status, :limit => 20, :comment =>"the status of the reversal/credit back to the corporate account"   
       t.datetime :reversed_at,  :comment =>"the timestamp when the reversal/credit back completed"   
     end
  end
end
