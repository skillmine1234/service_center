class CreateEcolAppUdtable < ActiveRecord::Migration
  def change
    create_table :ecol_app_udtable, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_code, null: false, comment: 'the app_code of the associated ecol_app for this record'
      t.string :udf1, null: false, limit: 100, comment: 'the value for udf1 for this record'
      t.string :udf2, limit: 100, comment: 'the value for udf2 for this record'
      t.string :udf3, limit: 100, comment: 'the value for udf3 for this record'
      t.string :udf4, limit: 100, comment: 'the value for udf4 for this record'
      t.string :udf5, limit: 100, comment: 'the value for udf5 for this record'
      
      t.datetime :created_at, null: false, comment: 'the timestamp when the record was created'
      t.datetime :updated_at, null: false, comment: 'the timestamp when the record was last updated'
      t.string :created_by, limit: 20, comment: 'the person who creates the record'
      t.string :updated_by, limit: 20, comment: 'the person who updates the record'
      t.integer :lock_version, null: false, default: 0, comment: 'the version number of the record, every update increments this by 1'

      t.approval_columns

      t.index([:app_code, :udf1, :approval_status], unique: true, name: 'ecol_app_udtable_01')
      t.index([:app_code, :udf1, :udf2, :udf3, :udf4, :udf5, :approval_status], name: 'ecol_app_udtable_02')
    end
  end
end
