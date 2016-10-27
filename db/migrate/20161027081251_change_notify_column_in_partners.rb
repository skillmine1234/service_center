class ChangeNotifyColumnInPartners < ActiveRecord::Migration
  def change
    db.execute "UPDATE partners SET notify_on_status_change = 'N'"
    change_column :partners, :notify_on_status_change, :string, :limit => 1, :null => false, :default => 'N', :comment => "the indicator to denote whether the alert has to be sent to partner on the transaction status changes"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
