class AddRequiredColumnToFundsTransfers < ActiveRecord::Migration
  def change
    add_column :ft_customers, :is_saf, :string, :limit => 1, :null => false, :default => 'N', :comment => "the minimum account balance to be maintained during the transfer"       
    add_column :funds_transfers, :picked_at, :datetime, :comment => "the timestamp when the transaction has been picked up to process"       
    add_column :funds_transfers, :received_at, :datetime, :comment => "the timestamp when the transaction has been received"       
    add_column :funds_transfers, :was_saf, :string, :limit => 1, :null => false, :default => 'N', :comment => "the identifier of the process mode of the transaction whether it is sync or async"       
    add_column :funds_transfers, :op_name, :string, :limit => 32, :comment => "the name of the operation from where the transaction has come"
  end   
end