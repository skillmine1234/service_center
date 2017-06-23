class ChangeColumnDataTypeInImtIncomingRecords < ActiveRecord::Migration
  def change
    change_column :imt_incoming_records, :total_net_position, :string, :limit => 50, :null => true, :comment => "the value of the position subtracting the initial cost of setting up the position"      
  end
end
