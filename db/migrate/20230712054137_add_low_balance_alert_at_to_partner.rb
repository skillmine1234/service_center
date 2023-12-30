class AddLowBalanceAlertAtToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :low_balannce_alert_at, :string
  end
end
