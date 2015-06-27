class AddApprovedIdToUdfAttributes < ActiveRecord::Migration
  def change
    add_column :udf_attributes, :approved_id, :integer
  end
end
