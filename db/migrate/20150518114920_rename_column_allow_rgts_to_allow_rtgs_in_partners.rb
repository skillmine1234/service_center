class RenameColumnAllowRgtsToAllowRtgsInPartners < ActiveRecord::Migration
  def up
  end

  def down
  end
  
  def change
    rename_column :partners, :allow_rgts, :allow_rtgs
  end
end
