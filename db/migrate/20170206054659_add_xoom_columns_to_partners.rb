class AddXoomColumnsToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :service_name, :string, limit: 5, null: false, default: 'INW', comment: 'the service used by the partner'
    add_column :partners, :guideline_id, :integer, null: false, default: 10000, comment: 'the guideline for the partner, refers to inw_guidelines'
    add_column :partners, :will_whitelist, :string, limit: 1, null: false, default: 'Y', comment: 'the identifier to specify if the partner is participating in the whitelisting process or not'
    add_column :partners, :will_send_id, :string, limit: 1, null: false, default: 'Y', comment: 'the identifier to specify if the partner will send ID information in the request'
    add_column :partners, :hold_for_whitelisting, :string, limit: 1, null: false, default: 'N', comment: 'the identifier to specify if the transaction should be held pending whitelisting'
    add_column :partners, :hold_period_days, :integer, null: false, default: 7, comment: 'the holding period of HELD transactions in days'
    add_column :partners, :auto_match_rule, :string, limit: 1, null: false, default: 'A', comment: 'the auto match rule, for an identitiy, N (None), A (any transactions for the party), B (only transactions between the same parties will be matched)'
    add_column :partners, :lcy_rate, :integer, null: false, default: 1, comment: 'the rate which will be used to convert the transaction amount from the lcy to the limit ccy'
  end
end
