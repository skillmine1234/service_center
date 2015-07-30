class CreateEcolPendingNotifications < ActiveRecord::Migration
  def change
    create_table :ecol_pending_notifications do |t|
      t.string :broker_uuid, :limit => 500
      t.references :ecol_transaction
      t.datetime :created_at
    end
  end
end