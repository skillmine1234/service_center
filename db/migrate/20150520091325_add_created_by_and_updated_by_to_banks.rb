class AddCreatedByAndUpdatedByToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :created_by, :string
    add_column :banks, :updated_by, :string
    add_column :banks, :lock_version, :integer, :default => 0, :null => false
  end
end
