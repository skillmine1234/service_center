class CreateSequenceQgApbsExtractRefSeq < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence qg_apbs_extract_ref_seq minvalue 1 cache 20'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence qg_apbs_extract_ref_seq'
    end
  end
end
