class AddSequenceForTraceId < ActiveRecord::Migration
  def up
    execute 'create sequence bm_trace_id_seq minvalue 1 nocache'
  end
  def down
    execute 'drop sequence bm_trace_id_seq'
  end
end
