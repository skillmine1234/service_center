class AddCreatedAndUpdatedByToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :created_by, :string, :limit => 20, :comment => 'the user who created the record'
    add_column :bm_rules, :updated_by, :string, :limit => 20, :comment => 'the user who updated the record'
  end
end
