class AddNewColumnsToScEvents < ActiveRecord::Migration
  def change
    add_column :sc_events, :event_type, :string, limit: 50, comment: 'the type of this event'
    add_column :sc_events, :service_code, :string, limit: 50, comment: 'the service_code for this event'
    add_column :sc_events, :db_unit_name, :string, limit: 50, comment: 'the db_unit name for this event'
    remove_index :sc_events, name: 'sc_events_01'
    add_index :sc_events, [:event, :service_code], unique: true, name: 'sc_events_01'
  end
end
