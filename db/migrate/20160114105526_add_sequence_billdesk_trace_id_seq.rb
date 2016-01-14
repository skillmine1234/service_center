class AddSequenceBilldeskTraceIdSeq < ActiveRecord::Migration
  def change
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence bm_trace_id_seq'
      execute 'drop sequence pc_trace_id_seq'
      execute 'create sequence billdesk_trace_id_seq'
    end
  end
end
