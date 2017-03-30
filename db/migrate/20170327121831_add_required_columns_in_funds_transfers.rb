class AddRequiredColumnsInFundsTransfers < ActiveRecord::Migration
  def change
    add_column :funds_transfers, :aadhar_no, :string, :limit => 12, :comment => "the aadhar number of the beneficiary for apbs transfer type"
    add_column :funds_transfers, :aadhar_mobile_no, :string, :limit => 20, :comment => "the mobile number which linked with aadhar for APBS transfer type"
    add_column :funds_transfers, :bene_bank_name, :string, :limit => 50, :comment => "the bene bank name returned from npci for APBS transfer type"  	
  end
end
