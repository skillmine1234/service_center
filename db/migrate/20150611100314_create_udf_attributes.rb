class CreateUdfAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :udf_attributes do  |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :class_name, :limit => 100, :null => false
      t.string :attribute_name, :limit => 100, :null => false
      t.string :label_text, :limit => 100, :null => false
      t.string :is_enabled, :limit => 1, :default => 'Y', :null => false
      t.string :is_mandatory, :limit => 1, :default => 'N', :null => false
      t.string :control_type, :limit => 255
      t.string :data_type, :limit => 255
      t.text :constraints
      t.text :select_options
      
      t.timestamps null: false
    end
  end
end
