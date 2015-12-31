class ChangeLimitOfStatusCodeInPcsPayToAccounts < ActiveRecord::Migration
  def change
    change_column :pcs_pay_to_accounts, :status_code, :string, :limit => 50, :null => false, :comment => "the status of this request"
  end
end
