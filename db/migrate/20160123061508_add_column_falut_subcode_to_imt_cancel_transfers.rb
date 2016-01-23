class AddColumnFalutSubcodeToImtCancelTransfers < ActiveRecord::Migration
  def change
    add_column :imt_cancel_transfers, :fault_subcode, :string, :limit => 50, :comment => "the error code that the third party will return"
  end
end
