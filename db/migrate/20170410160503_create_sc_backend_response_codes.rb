class CreateScBackendResponseCodes < ActiveRecord::Migration
  def change
    create_table :sc_backend_response_codes, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :is_enabled, limit: 1, null: false, comment: 'the flag which indicates whether this record is enabled or not'
      t.string :sc_backend_code, limit: 20, null: false, comment: 'the code assigned to the backend'
      t.string :response_code, limit: 50, null: false, comment: 'the response code sent by the backend'
      t.string :fault_code, limit: 50, null: false, comment: 'the fault code used for the backend response code'

      t.datetime :created_at, :null => false, :comment => "the timestamp when the record was created"
      t.datetime :updated_at, :null => false, :comment => "the timestamp when the record was last updated"
      t.string :created_by, :limit => 20, :comment => "the person who creates the record"
      t.string :updated_by, :limit => 20, :comment => "the person who updates the record"
      t.integer :lock_version, :null => false, :default => 0, :comment => "the version number of the record, every update increments this by 1"

      t.approval_columns

      t.index([:sc_backend_code, :response_code, :approval_status], :unique => true, name: 'sc_backend_response_codes_01')
    end
  end
end
