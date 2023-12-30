class ChangeRbiCodeInPurposeCodes < ActiveRecord::Migration[7.0]
  def change
    change_column :purpose_codes, :rbi_code, :string, :limit => 5
  end
end
