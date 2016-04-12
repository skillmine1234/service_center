class AddFaultSubcodeToIcPaynows < ActiveRecord::Migration
  def change
    add_column :ic_paynows, :fault_subcode, :string, :limit => 50,  :comment => "the error code that the third party will return"
    
  end
end
