class ChangeDescriptionInPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :description, :string, :limit => 255
  end
end
