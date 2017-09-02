class CreateIcolNotifications < ActiveRecord::Migration
  def change
    create_table :icol_notifications, {:sequence_start_value => '1 cache 20 order increment by 1'}  do |t|
      t.string :app_code, limit: 25, null: false, comment: 'the app_code for the step'
      t.string :customer_code, limit: 50, null: false, comment: 'the customer_code for this request'
      t.string :status_code, limit: 100, null: false, comment: 'the status of this transaction'
      t.string :company_name, limit: 100, comment: 'the company name'
      t.integer :txn_number, comment: 'the UTR for this transaction'
      t.string :txn_mode, limit: 3, comment: 'the mode for this transaction'
      t.datetime :txn_date, comment: 'the transaction timestamp'
      t.string :payment_status, limit: 3, comment: 'the payment status'
      t.string :template_data, limit: 1000, comment: 'the template data'
      t.integer :template_id, comment: 'the template id'
      t.datetime :created_at, comment: 'the timestamp when this record was created'
      t.string :pending_approval, limit: 1, comment: 'the indicator which decides whether this record is pending to be approved'
      t.index([:txn_number], unique: true, name: "icol_notifications_01")
    end
  end
end
