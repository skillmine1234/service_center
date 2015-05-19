class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.string :pattern_individuals, :limit => 4000
      t.string :pattern_corporates, :limit => 4000
      t.string :pattern_beneficiaries, :limit => 4000

      t.timestamps
    end
  end
end
