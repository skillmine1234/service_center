class CreateScEvents < ActiveRecord::Migration
  def change
    create_table :sc_events, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :event, null: false, comment: 'the name of the sc event'
      t.timestamps null: false
    end
    add_index :sc_events, :event, unique: true, name: 'sc_events_01'
  end
end
