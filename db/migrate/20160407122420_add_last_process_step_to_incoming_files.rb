class AddLastProcessStepToIncomingFiles < ActiveRecord::Migration
  def change
    add_column :incoming_files, :last_process_step, :string, :limit => 1, :comment => "the processing step, that was last completed - B (before first), R (record), A (after last)"
  end
end
