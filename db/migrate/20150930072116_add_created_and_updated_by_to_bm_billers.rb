class AddCreatedAndUpdatedByToBmBillers < ActiveRecord::Migration
  def change
    add_column :bm_billers, :created_by, :string, :limit => 20, :comment => 'the user who created the record'
    add_column :bm_billers, :updated_by, :string, :limit => 20, :comment => 'the user who updated the record'
  end
end
