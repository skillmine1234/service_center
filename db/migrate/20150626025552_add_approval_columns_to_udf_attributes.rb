class AddApprovalColumnsToUdfAttributes < ActiveRecord::Migration
  def change
    add_column :udf_attributes, :approval_status, :string, :limit => 1, :default => 'U'
    add_column :udf_attributes, :last_action, :string, :limit => 1, :default => 'C'
    add_column :udf_attributes, :approved_version, :integer
    remove_index :udf_attributes, :name => 'udf_attributes_unique_index'
    add_index :udf_attributes, [:class_name, :attribute_name,:approval_status], :unique => true, :name => 'udf_attribute_index_on_status'
  end
end
