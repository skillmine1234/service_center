class AddPartnerLcyRateForAllPartners < ActiveRecord::Migration
  def change
    partners = Partner.unscoped.all
    partners.each do |p|
      PartnerLcyRate.create(partner_code: p.code, rate: 1, approval_status: 'A') if p.partner_lcy_rate.nil?
    end
  end
end
