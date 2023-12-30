class AddUniqueIndexOnIfscInBanks < ActiveRecord::Migration[7.0]
  def change
    add_index :banks, :ifsc, unique: true
  end
end
