class CreateUserRoles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_roles do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.integer  "user_id"
      t.integer  "role_id"      
      t.timestamps
    end
  end
end
