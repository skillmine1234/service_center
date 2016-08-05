class AddProgramCodeToPcApps < ActiveRecord::Migration
  def change
    add_column :pc_apps, :program_code, :string, :limit => 15, :comment => "the code that identifies the program"
    db.execute "UPDATE pc_apps SET program_code = 'A'"
    change_column :pc_apps, :program_code, :string, :limit => 15, :null => false, :comment => "the code that identifies the program"
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
