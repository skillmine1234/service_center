class CreateEcolRules < ActiveRecord::Migration[7.0]
  def change
    create_table :ecol_rules do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :ifsc, :limit => 11, :null => false
      t.string :cod_acct_no, :limit => 15, :null => false
      t.string :stl_gl_inward, :limit => 15, :null => false
      t.string :stl_gl_return, :limit => 15, :null => false
      t.string :created_by, :limit => 20
      t.string :updated_by, :limit => 20
      t.string :lock_version, :null => false, :default => 0

      t.timestamps null: false
    end
  end
end
