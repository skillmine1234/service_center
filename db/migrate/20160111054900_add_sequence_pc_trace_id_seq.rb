class AddSequencePcTraceIdSeq < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence pc_trace_id_seq minvalue 1 nocache'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence pc_trace_id_seq'
    end
  end
end
