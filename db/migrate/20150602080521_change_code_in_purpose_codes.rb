class ChangeCodeInPurposeCodes < ActiveRecord::Migration
  def change
    change_column :purpose_codes, :code, :string, :limit => 4
    change_column :purpose_codes, :rbi_code, :string, :limit => 4
  end
end
