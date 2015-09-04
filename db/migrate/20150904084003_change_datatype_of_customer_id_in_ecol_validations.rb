class ChangeDatatypeOfCustomerIdInEcolValidations < ActiveRecord::Migration
  def change
    change_column :ecol_validations, :ecol_customer_id, :string
  end
end
