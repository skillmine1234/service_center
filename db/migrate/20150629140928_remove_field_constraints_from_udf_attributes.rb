class RemoveFieldConstraintsFromUdfAttributes < ActiveRecord::Migration
  def change
    remove_column :udf_attributes, :field_constraints
  end
end
