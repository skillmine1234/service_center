class ChangeLimitOfCodeInPartners < ActiveRecord::Migration
  def change
    change_column :partners, :code, :string, :limit => 10
  end
end
