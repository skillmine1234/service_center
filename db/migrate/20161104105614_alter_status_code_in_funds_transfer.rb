class AlterStatusCodeInFundsTransfer < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      change_column :funds_transfers, :status_code, :string, :limit => 30, :comment => 'the status of the request'
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      change_column :funds_transfers, :status_code, :string, :limit => 25, :comment => 'the status of the request'
    end
  end
end
