class CreateRules < ActiveRecord::Migration[7.0]
  def change
    create_table :rules do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :pattern_individuals, :limit => 4000
      t.string :pattern_corporates, :limit => 4000
      t.string :pattern_beneficiaries, :limit => 4000

      t.timestamps
    end
  end
end
