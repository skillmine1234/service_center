class AddColumnBeneNameToPcsPayToAccounts < ActiveRecord::Migration
  def change
    add_column :pcs_pay_to_accounts, :bene_name, :string, :limit => 255, :comment => 'the name of the beneficiary'
    db.execute "UPDATE pcs_pay_to_accounts SET bene_name = 'A' "
    change_column :pcs_pay_to_accounts, :bene_name, :string, :null => false
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
