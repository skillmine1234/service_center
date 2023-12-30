class ChangeIndexInScBackends < ActiveRecord::Migration[7.0]
  def change
    #remove_index :sc_backends, :name => 'sc_backends_01'
    #add_index :sc_backends, [:code, :approval_status], :name => "sc_backends_01", :unique => true
  end
end
