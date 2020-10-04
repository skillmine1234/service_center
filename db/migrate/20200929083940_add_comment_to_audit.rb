class AddCommentToAudit < ActiveRecord::Migration
  def change
    add_column 'obdx.audits', :comment, :string
  end
end
