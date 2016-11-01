class AddIndexesOnInwPendingConfirmations < ActiveRecord::Migration
  def up
    add_index :inw_pending_confirmations, [:inw_auditable_type, :inw_auditable_id], :unique => true, :name => 'inw_confirmations_01'
    add_index :inw_pending_confirmations, [:broker_uuid, :created_at], :name => 'inw_confirmations_02'
  end

  def down
    remove_index :inw_pending_confirmations, :name => 'inw_confirmations_01'
    remove_index :inw_pending_confirmations, :name => 'inw_confirmations_02'
  end
end
