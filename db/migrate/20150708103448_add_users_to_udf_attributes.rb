class AddUsersToUdfAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :udf_attributes, :created_by, :string, :limit => 20
    add_column :udf_attributes, :updated_by, :string, :limit => 20
  end
end
