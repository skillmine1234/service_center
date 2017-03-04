class RenameBeneMailIdToBeneEmailIdInCnb2IncomingRecords < ActiveRecord::Migration
  def change
    rename_column :cnb2_incoming_records, :bene_mail_id, :bene_email_id    
  end
end
