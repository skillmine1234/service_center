class RemoveMmColumnsAndAddPcProgramIdToPcApps < ActiveRecord::Migration
  def change
    remove_column :pc_apps, :mm_host
    remove_column :pc_apps, :mm_consumer_key 
    remove_column :pc_apps, :mm_consumer_secret
    remove_column :pc_apps, :mm_card_type
    remove_column :pc_apps, :mm_email_domain
    remove_column :pc_apps, :mm_admin_host
    remove_column :pc_apps, :mm_admin_user   
    remove_column :pc_apps, :mm_admin_password
    add_column :pc_apps, :pc_program_id, :integer, :comment => "the id of the pc_programs record associated with this transaction"
    db.execute "UPDATE pc_apps SET pc_program_id = 0"
    change_column :pc_apps, :pc_program_id, :integer, :null => false, :comment => "the id of the pc_programs record associated with this transaction"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
