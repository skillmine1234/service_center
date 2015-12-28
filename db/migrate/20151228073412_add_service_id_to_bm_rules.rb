class AddServiceIdToBmRules < ActiveRecord::Migration
  def change
    add_column :bm_rules, :service_id, :string, :limit => 255
  end
end
