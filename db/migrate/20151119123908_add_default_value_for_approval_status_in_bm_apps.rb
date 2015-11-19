class AddDefaultValueForApprovalStatusInBmApps < ActiveRecord::Migration
  def change
    change_column :bm_apps, :approval_status, :string, :default => "U"
  end
end
