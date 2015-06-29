class AddFieldConstraintsToUdfAttributes < ActiveRecord::Migration
  def change
    add_column :udf_attributes, :field_constraints, :text
  end
end
