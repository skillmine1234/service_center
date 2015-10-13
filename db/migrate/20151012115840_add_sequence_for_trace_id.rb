class AddSequenceForTraceId < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence bm_trace_id_seq minvalue 1 nocache'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence bm_trace_id_seq'
    end
  end
end
