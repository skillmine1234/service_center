unless Rails.env == 'production'
  if EcolRule.all.empty?
    EcolRule.seed do |ecol_rule|
      ecol_rule.ifsc = "QGPL0123456"
      ecol_rule.cod_acct_no = "0123456789"
      ecol_rule.stl_gl_inward = "123456789"
      ecol_rule.approval_status = 'A'
      ecol_rule.neft_sender_ifsc = "ABCD0123456"
      ecol_rule.customer_id = "QWEASD"
    end
  end
end