class AddLiquityProviderIdToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :liquity_provider_id, :string
  end
end
