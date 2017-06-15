class DropSequenceNpciTxnRefSeq < ActiveRecord::Migration
  def change
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence npci_txn_ref_seq'
    end
  end
end
