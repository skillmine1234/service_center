class AddPartnerLcyRateForAllPartners < ActiveRecord::Migration[7.0]
  def change
    #Partner.unscope.find_each(batch_size: 100) do |p|
      #PartnerLcyRate.create(partner_code: p.code, rate: 1, approval_status: 'A') if p.partner_lcy_rate.nil?
    #end
  end
end
