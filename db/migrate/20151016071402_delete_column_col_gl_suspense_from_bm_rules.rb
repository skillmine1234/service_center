class DeleteColumnColGlSuspenseFromBmRules < ActiveRecord::Migration
  def change
    remove_column :bm_rules, :cod_gl_suspense, :string
  end
end
