class AddColumnEmailIdInIamOrganisations < ActiveRecord::Migration
  def change
    add_column :iam_organisations, :email_id, :string, :comment => "the email id of the organisation"
  end
end
