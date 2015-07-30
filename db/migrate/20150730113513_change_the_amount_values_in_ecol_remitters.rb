class ChangeTheAmountValuesInEcolRemitters < ActiveRecord::Migration
  def change
    EcolRemitter.find_each(batch_size: 100) do |remitter|
      remitter.invoice_amt = remitter.invoice_amt.round(2)
      remitter.min_credit_amt = remitter.min_credit_amt.round(2)
      remitter.max_credit_amt = remitter.max_credit_amt.round(2)
      remitter.save(:validate => false)
    end
  end
end
