class RenameAadharNoAadharMobileNoInFundsTransfers < ActiveRecord::Migration
  def change
    rename_column :funds_transfers, :aadhar_no, :aadhaar_no
    rename_column :funds_transfers, :aadhar_mobile_no, :aadhaar_mobile_no    
  end
end
