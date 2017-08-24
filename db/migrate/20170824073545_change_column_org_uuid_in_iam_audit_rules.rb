class ChangeColumnOrgUuidInIamAuditRules < ActiveRecord::Migration
  def change
    change_column :iam_audit_rules, :org_uuid, :string, limit: 100
  end
end
