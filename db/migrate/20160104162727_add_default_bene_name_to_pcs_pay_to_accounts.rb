class AddDefaultBeneNameToPcsPayToAccounts < ActiveRecord::Migration
  def change
    change_column :pcs_pay_to_accounts, :bene_name, :string, default: ""
  end
end
