class ChangeDefaultValueOfApprovalStatusInBmRules < ActiveRecord::Migration
  def change
    change_column :bm_rules, :approval_status, :string, :default => "U"
  end
end
