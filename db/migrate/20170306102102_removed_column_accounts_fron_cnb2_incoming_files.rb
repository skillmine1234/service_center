class RemovedColumnAccountsFronCnb2IncomingFiles < ActiveRecord::Migration
  def change
    remove_column :cnb2_incoming_files, :account       
  end
end
