class AddAadhaarDetailColumnsToFtIncomingRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_incoming_records, :aadhaar_no, :string, :limit => 12, :comment => "the aadhar number of the beneficiary for apbs transfer type"
    add_column :ft_incoming_records, :aadhaar_mobile_no, :string, :limit => 20, :comment => "the mobile number which linked with aadhar for APBS transfer type"    
  end
end
