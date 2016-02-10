class CreateScServices < ActiveRecord::Migration
  def change
    create_table :sc_services, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :code, :limit => 50, :null => false
      t.string :name, :limit => 50, :null => false
    end
    add_index :sc_services, :code, :unique => true
    add_index :sc_services, :name, :unique => true
  end
end
