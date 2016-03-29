class AddRetryColumnsToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :pending_approval, :string, :limit => 1, :comment => "the indicator that tells whether an approval is awaited by the ESB"
  end
end
