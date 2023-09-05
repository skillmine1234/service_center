class AddRmtrCodeToInwardRemittances < ActiveRecord::Migration[7.0]
  def change
    add_column :inward_remittances, :rmtr_code, :string, limit: 30, comment: 'the partner assigned code of the remitter to which the identity belongs'
  end
end
