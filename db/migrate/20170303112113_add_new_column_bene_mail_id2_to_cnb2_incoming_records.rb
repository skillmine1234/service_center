class AddNewColumnBeneMailId2ToCnb2IncomingRecords < ActiveRecord::Migration
  def change
    add_column :cnb2_incoming_records, :bene_email_id_2, :string, :limit => 1000, :comment => "the email id of beneficiary"    
  end
end
