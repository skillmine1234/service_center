class RemoveNotNullConstraintsFromSmBankAccounts < ActiveRecord::Migration[7.0]
  def change
    change_column :sm_bank_accounts, :mmid, :string, :null => true, :limit => 7, :comment => "the mmid for the account, required for imps"
    change_column :sm_bank_accounts, :mobile_no, :string, :null => true, :limit => 10, :comment => "the mobile no as registered with the mmid, required for imps"
  end
end
