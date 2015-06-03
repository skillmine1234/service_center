class ChangeAccountIfscInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :account_ifsc, :string, :limit => 20, :null => true
  end
end
