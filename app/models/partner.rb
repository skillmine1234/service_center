class Partner < ActiveRecord::Base
  attr_accessible :account_ifsc, :account_no, :allow_imps, :allow_neft, :allow_rgts, :beneficiary_email_allowed, :beneficiary_sms_allowed, :code, :created_by, :identity_user_id, :low_balance_alert_at, :name, :ops_email_id, :remitter_email_allowed, :remitter_sms_allowed, :tech_email_id, :txn_hold_period_days, :updated_by
end
