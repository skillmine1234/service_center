class CreateGroups <  ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :name

      t.timestamps null: false
    end
  end
end
