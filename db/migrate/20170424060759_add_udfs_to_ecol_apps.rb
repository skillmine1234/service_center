class AddUdfsToEcolApps < ActiveRecord::Migration
  def change
    add_column :ecol_apps, :udfs_cnt, :integer, default: 0, comment: 'the count of udfs for this ecol_app'
    add_column :ecol_apps, :unique_udfs_cnt, :integer, default: 0, comment: 'the count of unique indexes on udfs for this ecol_app'
    add_column :ecol_apps, :udf1, :string, comment: 'the udf1 for this ecol_app'
    add_column :ecol_apps, :udf2, :string, comment: 'the udf2 for this ecol_app'
    add_column :ecol_apps, :udf3, :string, comment: 'the udf3 for this ecol_app'
    add_column :ecol_apps, :udf4, :string, comment: 'the udf4 for this ecol_app'
    add_column :ecol_apps, :udf5, :string, comment: 'the udf5 for this ecol_app'
  end
end
