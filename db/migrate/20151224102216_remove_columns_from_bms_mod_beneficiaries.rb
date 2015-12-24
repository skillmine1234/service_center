class RemoveColumnsFromBmsModBeneficiaries < ActiveRecord::Migration
  def change
    remove_column :bms_mod_beneficiaries, :otp_key
    remove_column :bms_mod_beneficiaries, :otp_value
  end
end
