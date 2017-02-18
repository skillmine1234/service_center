class RemoveLcyRateFromPartners < ActiveRecord::Migration
  def change
    partners = Partner.where("lcy_rate is not null")
    partners.each do |p|
      PartnerLcyRate.create!(partner_code: p.code, rate: p.lcy_rate, approval_status: 'A')
    end
    remove_column :partners, :lcy_rate
  end
end
