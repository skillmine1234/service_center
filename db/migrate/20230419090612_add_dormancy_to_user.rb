class AddDormancyToUser < ActiveRecord::Migration
  def change
    add_column :users, :dormancy, :string, :default => 'N'
  end
end
