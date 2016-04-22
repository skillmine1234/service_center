class AddSequenceToFmAuditSteps < ActiveRecord::Migration
  def change
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'alter sequence fm_audit_steps_seq minvalue 1 cache 20 order increment by 1'
    end
  end
end