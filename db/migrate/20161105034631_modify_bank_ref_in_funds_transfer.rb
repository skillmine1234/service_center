class ModifyBankRefInFundsTransfer < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      change_column :funds_transfers, :bank_ref, :string, :limit => 50, :comment => 'the reference number generated by the bank'
    end
  end

  def down
    if ActiveRecord::Base.connection.table_exists? 'funds_transfers'
      change_column :funds_transfers, :bank_ref, :string, :limit => 30, :comment => 'the reference number generated by the bank'
    end
  end
end
