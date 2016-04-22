class AddSequenceToFmAuditSteps < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence fm_audit_steps_seq minvalue 1 cache 20'
    end
  end

  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence fm_audit_steps_seq'
    end
 end
end
