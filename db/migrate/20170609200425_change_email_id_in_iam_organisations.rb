class ChangeEmailIdInIamOrganisations < ActiveRecord::Migration
  def change
    IamOrganisation.update_all(email_id: 'a')
    change_column :iam_organisations, :email_id, :string, :null => false
  end
end
