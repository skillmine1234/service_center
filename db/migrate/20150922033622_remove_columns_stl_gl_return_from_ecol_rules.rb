class RemoveColumnsStlGlReturnFromEcolRules < ActiveRecord::Migration
  def change
    remove_column :ecol_rules, :stl_gl_return
  end
end
