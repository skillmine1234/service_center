class RemoveColumnsFromImtTransfers < ActiveRecord::Migration
  def change
    remove_column :imt_transfers, :initiation_ref_no
    remove_column :imt_transfers, :cancellation_ref_no
  end
end
