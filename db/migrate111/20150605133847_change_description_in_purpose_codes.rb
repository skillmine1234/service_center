class ChangeDescriptionInPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    change_column :purpose_codes, :description, :string, :limit => 255
  end
end
