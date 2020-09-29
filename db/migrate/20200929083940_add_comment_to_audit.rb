class AddCommentToAudit < ActiveRecord::Migration
  def change
    add_column 'inw.audits', :comment, :string
  end
end
