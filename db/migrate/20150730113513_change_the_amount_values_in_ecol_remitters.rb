class ChangeTheAmountValuesInEcolRemitters < ActiveRecord::Migration
  def change
    EcolRemitter.find_each(batch_size: 100) do |remitter|
      remitter.invoice_amt = remitter.invoice_amt.round(2) unless remitter.invoice_amt.nil?
      remitter.min_credit_amt = remitter.min_credit_amt.round(2) unless remitter.min_credit_amt.nil?
      remitter.max_credit_amt = remitter.max_credit_amt.round(2) unless remitter.max_credit_amt.nil?
      remitter.save(:validate => false)
    end
  end
end
