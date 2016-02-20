class AddSequenceFlexUrnSeq < ActiveRecord::Migration
  def up
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'create sequence flex_urn_seq minvalue 1 nocache'
    end
  end
  def down
    if Rails.configuration.database_configuration[Rails.env]["adapter"] == 'oracle_enhanced'
      execute 'drop sequence flex_urn_seq'
    end
  end
end