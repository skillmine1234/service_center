class RenameReqTimeInInwardRemittances < ActiveRecord::Migration[7.0]
  def up
    #rename_column :inward_remittances, :req_time, :req_timestamp
  end

  def down
    #rename_column :inward_remittances, :req_timestamp, :req_time
  end
end
