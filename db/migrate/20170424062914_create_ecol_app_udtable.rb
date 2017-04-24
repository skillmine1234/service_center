class CreateEcolAppUdtable < ActiveRecord::Migration
  def change
    create_table :ecol_app_udtable do |t|
      t.string :app_code, null: false, comment: 'the app_code of the associated ecol_app for this record'
      t.string :udf1, null: false, comment: 'the value for udf1 for this record'
      t.string :udf2, null: false, comment: 'the value for udf2 for this record'
      t.string :udf3, null: false, comment: 'the value for udf3 for this record'
      t.string :udf4, null: false, comment: 'the value for udf4 for this record'
      t.string :udf5, null: false, comment: 'the value for udf5 for this record'
      
      t.datetime :created_at, null: false, comment: 'the timestamp when the record was created'
      t.datetime :updated_at, null: false, comment: 'the timestamp when the record was last updated'
      t.string :created_by, limit: 20, comment: 'the person who creates the record'
      t.string :updated_by, limit: 20, comment: 'the person who updates the record'
      t.integer :lock_version, null: false, default: 0, comment: 'the version number of the record, every update increments this by 1'

      t.approval_columns
    end
  end
end
