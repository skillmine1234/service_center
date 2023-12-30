class AddServiceIdToBmRules < ActiveRecord::Migration[7.0]
  def change
    add_column :bm_rules, :service_id, :string, :limit => 255
  end
end
