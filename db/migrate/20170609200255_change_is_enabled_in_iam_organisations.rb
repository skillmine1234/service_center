class ChangeIsEnabledInIamOrganisations < ActiveRecord::Migration
  def change
    change_column :iam_organisations, :is_enabled, :string, :default => 'Y'
  end
end
