class RemoveNotNullConstraintsFromUdfAttributes < ActiveRecord::Migration
  def change
    change_column :udf_attributes, :label_text, :string, :null => true
    change_column :udf_attributes, :is_mandatory, :string, :null => true
    add_index :udf_attributes, [:class_name, :attribute_name], :unique => true, :name => 'udf_attributes_unique_index'
  end

end
