class AddColumnIsEnabledToSmBanks < ActiveRecord::Migration[7.0]
  def up
    add_column :sm_banks, :is_enabled, :string, :limit => 1, :comment => "the flag to decide if the bank is enabled or not"
    db.execute "UPDATE sm_banks SET is_enabled = 'Y'"
    change_column :sm_banks, :is_enabled, :string, :null => false, :default => 'Y', :limit => 1, :comment => "the flag to decide if the bank is enabled or not"
  end
      
  def down
    remove_column :sm_banks, :is_enabled
  end

  private

  def db
    ActiveRecord::Base.connection
  end
end
