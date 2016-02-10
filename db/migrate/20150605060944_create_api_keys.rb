class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :access_token

      t.timestamps null: false
    end
  end
end
