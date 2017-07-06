class ChangeLengthOfCertDnInIamOrganisations < ActiveRecord::Migration
  def change
    change_column :iam_organisations, :cert_dn, :string, limit: 300
  end
end
