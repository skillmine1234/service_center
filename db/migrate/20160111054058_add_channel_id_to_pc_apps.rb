class AddChannelIdToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :channel_id, :string, :limit => 20, :comment => 'the id of the channel which will be used for payment mode'
    db.execute "UPDATE pc_apps SET channel_id = 'a' "
    change_column :pc_apps, :channel_id, :string, :limit => 20, :null => false, :comment => 'the id of the channel which will be used for payment mode'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
