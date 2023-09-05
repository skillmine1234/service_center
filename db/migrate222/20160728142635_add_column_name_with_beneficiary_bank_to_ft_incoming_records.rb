class AddColumnNameWithBeneficiaryBankToFtIncomingRecords < ActiveRecord::Migration[7.0]
  def change
    add_column :ft_incoming_records, :name_with_bene_bank, :string, :limit => 255, :comment => "the name as registered with the beneficiary bank"
  end
end
