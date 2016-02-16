class AddSequenceYcsTxnRefSeq < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence ycs_txn_ref_seq minvalue 1 nocache'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence ycs_txn_ref_seq'
    end
  end
end
  