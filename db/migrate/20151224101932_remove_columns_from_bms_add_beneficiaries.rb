class RemoveColumnsFromBmsAddBeneficiaries < ActiveRecord::Migration
  def change
    remove_column :bms_add_beneficiaries, :otp_key
    remove_column :bms_add_beneficiaries, :otp_value
    remove_column :bms_add_beneficiaries, :string
  end
end
