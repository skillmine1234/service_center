class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string :code, :limit => 20, :null => false
      t.string :name, :limit => 20, :null => false
      t.string :tech_email_id
      t.string :ops_email_id
      t.string :account_no, :limit => 20, :null => false
      t.string :account_ifsc, :limit => 20, :null => false
      t.integer :txn_hold_period_days, :default => 7, :null => false
      t.string :identity_user_id, :limit => 20
      t.float :low_balance_alert_at
      t.string :remitter_sms_allowed, :limit => 1
      t.string :remitter_email_allowed, :limit => 1
      t.string :beneficiary_sms_allowed, :limit => 1
      t.string :beneficiary_email_allowed, :limit => 1
      t.string :allow_neft, :limit => 1
      t.string :allow_rgts, :limit => 1
      t.string :allow_imps, :limit => 1
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20

      t.timestamps
    end
  end
end
