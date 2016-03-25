require 'spec_helper'

describe EncPassGenerator do

  context 'password_generation' do
    it "should generate encrypted_password" do
      enc_pass = EncPassGenerator.new("password_string", "MyString", "MyString")
      encrypted_password = enc_pass.send(:generate_encrypted_password)
      expect(encrypted_password).to_not be_nil
      expect(encrypted_password.size).to eq(50)
    end
  end
  
end