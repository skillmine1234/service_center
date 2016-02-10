unless Rails.env == 'production'
  if BmRule.all.empty?
    BmRule.seed do |bm_rule|
      bm_rule.cod_acct_no = "0123456789"
      bm_rule.customer_id = "QWEASD"
      bm_rule.bene_acct_no = "0123456788"
      bm_rule.bene_account_ifsc = "IFSC0123456"
      bm_rule.neft_sender_ifsc = "IFSC0123456"
      bm_rule.approval_status = 'A'
      bm_rule.service_id = 'NETUSER'
    end
  end
end