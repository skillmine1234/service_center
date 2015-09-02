class CreateEcolNotifications < ActiveRecord::Migration
  def change
    create_table :ecol_notifications do |t|
      t.integer :ecol_transaction_id
      t.integer :ecol_customer_id
      t.string :notification_for, :limit => 1
      t.string :status_code, :limit => 10
      t.text :req_bitstream
      t.text :rep_bitstream
    end
  end
end
