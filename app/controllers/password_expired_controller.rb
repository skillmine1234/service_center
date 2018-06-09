class PasswordExpiredController < Devise::PasswordExpiredController
  include EncryptedField::ControllerAdditions

  private
    def resource_params
      hash = params.require(resource_name).permit(:current_password, :password, :password_confirmation)
      hash.update(hash) { |key, value| decrypt_encrypted_field(value) }
      return hash
    end
end
