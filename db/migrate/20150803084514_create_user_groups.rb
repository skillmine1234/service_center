class CreateUserGroups < ActiveRecord::Migration
  def change
    create_table :user_groups, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.references :user
      t.references :group
    end
  end
end
