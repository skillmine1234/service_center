class ChangingStringColumnInUdfAttributes < ActiveRecord::Migration
  def change
    remove_column :udf_attributes, :constraints
    remove_column :udf_attributes, :select_options
    add_column :udf_attributes, :constraints, :text
  end
end
