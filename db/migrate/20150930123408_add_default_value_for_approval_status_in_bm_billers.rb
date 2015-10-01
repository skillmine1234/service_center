class AddDefaultValueForApprovalStatusInBmBillers < ActiveRecord::Migration
  def change
    change_column :bm_billers, :approval_status, :string, :default => 'U'
  end
end
