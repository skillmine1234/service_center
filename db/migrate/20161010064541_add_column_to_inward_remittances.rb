class AddColumnToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :processed_at, :datetime, :comment => 'the timestamp when transaction has processed successfully'
  end
end
