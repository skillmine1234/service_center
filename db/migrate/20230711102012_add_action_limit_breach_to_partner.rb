class AddActionLimitBreachToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :action_limit_breach, :string
  end
end
