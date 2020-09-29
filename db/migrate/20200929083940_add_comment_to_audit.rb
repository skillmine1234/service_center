class AddCommentToAudit < ActiveRecord::Migration
  def change
    add_column :audits, :comment, :string
  end
end
