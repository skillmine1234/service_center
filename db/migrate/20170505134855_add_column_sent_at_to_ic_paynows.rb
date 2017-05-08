class AddColumnSentAtToIcPaynows < ActiveRecord::Migration
  def change
    add_column :ic_paynows, :sent_at, :datetime, comment: 'the timestamp which indicates the time when status changed to sent from onhold'    
  end
end
