class AddColumnBeneNameToPcsPayToAccounts < ActiveRecord::Migration
  def change
    add_column :pcs_pay_to_accounts, :bene_name, :string, :limit => 255, :comment => 'the name of the beneficiary'
    change_column :pcs_pay_to_accounts, :bene_name, :string, :null => false
  end
end
