class ChangeBankRefInInwardRemittances < ActiveRecord::Migration
  def change
    change_column :inward_remittances, :bank_ref, :string, :limit => 30
  end
end
