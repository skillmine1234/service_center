class AddAutoMatchRuleToPartner < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :auto_match_rule, :string
  end
end
