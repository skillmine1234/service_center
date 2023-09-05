class RemoveColumnsStlGlReturnFromEcolRules < ActiveRecord::Migration[7.0]
  def change
    remove_column :ecol_rules, :stl_gl_return
  end
end
