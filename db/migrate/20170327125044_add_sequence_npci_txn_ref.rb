class AddSequenceNpciTxnRef < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence npci_txn_ref_seq minvalue 1 cache 20'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence npci_txn_ref_seq'
    end
  end
end