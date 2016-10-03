class CreateSequenceRcBatchNo < ActiveRecord::Migration
  def change
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence rc_batch_no_seq'    
    end
  end
end
