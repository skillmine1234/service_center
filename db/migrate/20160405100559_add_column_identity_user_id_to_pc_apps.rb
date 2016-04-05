class AddColumnIdentityUserIdToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :identity_user_id, :string, :limit => 20, :comment => 'the identity of the user'
    db.execute "UPDATE pc_apps SET identity_user_id = 'a'"
    change_column :pc_apps, :identity_user_id, :string, :limit => 20, :null => false, :comment => 'the identity of the user'
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
