class ChangeRbiCodeInPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :rbi_code, :string, :limit => 5
  end
end
