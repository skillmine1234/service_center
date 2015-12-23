class ConvertEcolValuesToUpcase < ActiveRecord::Migration
  def change
    ecol_customers = EcolCustomer.unscoped.all
    unless ecol_customers.empty?
      ecol_customers.each do |customer|
        customer.update_attributes(:code => customer.code.upcase, 
                                   :token_1_starts_with => (customer.token_1_starts_with.present? ? customer.token_1_starts_with.upcase : nil), 
                                   :token_1_contains => (customer.token_1_contains.present? ? customer.token_1_contains.upcase : nil), 
                                   :token_1_ends_with => (customer.token_1_ends_with.present? ? customer.token_1_ends_with.upcase : nil),
                                   :token_2_starts_with => (customer.token_2_starts_with.present? ? customer.token_2_starts_with.upcase : nil), 
                                   :token_2_contains => (customer.token_2_contains.present? ? customer.token_2_contains.upcase : nil), 
                                   :token_2_ends_with => (customer.token_2_ends_with.present? ? customer.token_2_ends_with.upcase : nil), 
                                   :token_3_starts_with => (customer.token_3_starts_with.present? ? customer.token_3_starts_with.upcase : nil), 
                                   :token_3_contains => (customer.token_3_contains.present? ? customer.token_3_contains.upcase : nil), 
                                   :token_3_ends_with => (customer.token_3_ends_with.present? ? customer.token_3_ends_with.upcase : nil))
        customer.save
      end
    end
    
    ecol_remitters = EcolRemitter.unscoped.all
    unless ecol_remitters.empty?
      ecol_remitters.each do |remitter|
        remitter.update_attributes(:customer_code => remitter.customer_code.upcase, 
                                   :remitter_code => (remitter.remitter_code.present? ? remitter.remitter_code.upcase : nil), 
                                   :invoice_no => (remitter.invoice_no.present? ? remitter.invoice_no.upcase : nil))
        remitter.save
      end
    end
  end
end
