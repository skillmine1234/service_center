class RemoveTimestampsFromInwardRemittance < ActiveRecord::Migration
  def change
    remove_column :inward_remittances, :created_at, :updated_at
  end
end
