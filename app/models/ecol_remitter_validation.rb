module EcolRemitterValidation
  extend ActiveSupport::Concern
  included do
    validate :validate_customer_subcode_details, :customer_code_should_exist, :check_email_address  
  end

  def validate_customer_subcode_details
    if self.customer_subcode.blank? 
      errors.add(:customer_subcode_email,"should be empty when customer_subcode is empty") if !self.customer_subcode_email.blank?
      errors.add(:customer_subcode_mobile,"should be empty when customer_subcode is empty") if !self.customer_subcode_mobile.blank?
    end
  end 

  def check_email_address
    ["customer_subcode_email","rmtr_email"].each do |email_id|
      invalid_ids = []
      value = self.send(email_id)
      unless value.nil?
        value.split(/;\s*/).each do |email| 
          unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
            invalid_ids << email
          end
        end
      end
      errors.add(email_id.to_sym, "invalid email #{invalid_ids.join(',')}") unless invalid_ids.empty?
    end
  end

  def customer_code_should_exist
    ecol_customer = EcolCustomer.where(:code => self.customer_code)
    if ecol_customer.empty? 
      errors.add(:customer_code, "Invalid Customer")
    end
  end
end