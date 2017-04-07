class RenameAadharNoAadharMobileNoInFundsTransfers < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      rename_column :funds_transfers, :aadhar_no, :aadhaar_no
      rename_column :funds_transfers, :aadhar_mobile_no, :aadhaar_mobile_no
    end
  end
end
