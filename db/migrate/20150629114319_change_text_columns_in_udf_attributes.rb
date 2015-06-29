class ChangeTextColumnsInUdfAttributes < ActiveRecord::Migration
  def change
    remove_column :udf_attributes, :constraints
    remove_column :udf_attributes, :select_options
    add_column :udf_attributes, :constraints, :string, :limit => 4000
    add_column :udf_attributes, :select_options, :string, :limit => 4000
  end
end
