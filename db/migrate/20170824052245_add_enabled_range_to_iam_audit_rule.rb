class AddEnabledRangeToIamAuditRule < ActiveRecord::Migration
  def change
    remove_column :iam_audit_rules, :cert_dn
    remove_column :iam_audit_rules, :source_ip
    remove_column :iam_audit_rules, :org_uuid
        
    add_column :iam_audit_rules, :log_bad_org_uuid, :string, null: false, default: 'N', limit: 1, comment: 'the timestamp when the log was last enabled'
    add_column :iam_audit_rules, :iam_organisation_id, :int, comment: 'the organisation for which the log is enabled (only 1 org is enabled at a time)'

    add_column :iam_audit_rules, :enabled_at, :datetime, null: false, default: Time.zone.now, comment: 'the timestamp when the log was last enabled'
  end
end
