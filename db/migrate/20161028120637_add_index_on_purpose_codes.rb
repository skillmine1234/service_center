class AddIndexOnPurposeCodes < ActiveRecord::Migration
  def change
    add_index :purpose_codes, [:code, :approval_status], :unique => true, :name => 'purpose_codes_01'
  end
end
