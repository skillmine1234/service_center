class AddSequenceImtBankRefSeq < ActiveRecord::Migration[7.0]
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence imt_bank_ref_seq order cache 20'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence imt_bank_ref_seq'
    end
  end
end
