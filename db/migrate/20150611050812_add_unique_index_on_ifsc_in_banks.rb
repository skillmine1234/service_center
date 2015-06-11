class AddUniqueIndexOnIfscInBanks < ActiveRecord::Migration
  def change
    add_index :banks, :ifsc, unique: true
  end
end
