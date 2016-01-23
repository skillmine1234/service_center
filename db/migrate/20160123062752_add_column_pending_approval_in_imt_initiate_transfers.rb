class AddColumnPendingApprovalInImtInitiateTransfers < ActiveRecord::Migration
  def change
    add_column :imt_initiate_transfers, :pending_approval, :string, :limit => 1, :default => 'Y', :comment => "the flag which indicates whether the transaction is approved or not"
    db.execute "UPDATE imt_initiate_transfers SET pending_approval = 'Y'"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
