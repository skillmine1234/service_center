class RemoveIsEnabledFromPartnerLcyRates < ActiveRecord::Migration
  def change
    remove_column :partner_lcy_rates, :is_enabled
  end
end
