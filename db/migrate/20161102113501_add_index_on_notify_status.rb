class AddIndexOnNotifyStatus < ActiveRecord::Migration
  def change
    add_index :inward_remittances, :notify_status, :name => 'inward_remittances_01'
  end
end
