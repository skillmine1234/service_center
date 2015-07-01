class ConvertStringToTextInUdfAttributes < ActiveRecord::Migration
  def change
    remove_column :udf_attributes, :constraints
    remove_column :udf_attributes, :select_options
    add_column :udf_attributes, :constraints, :text
    add_column :udf_attributes, :select_options, :text
  end
end
