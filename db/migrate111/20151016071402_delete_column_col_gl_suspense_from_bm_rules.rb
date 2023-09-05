class DeleteColumnColGlSuspenseFromBmRules < ActiveRecord::Migration[7.0]
  def change
    remove_column :bm_rules, :cod_gl_suspense, :string
  end
end
