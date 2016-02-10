unless Rails.env == 'production'
  if InwRemittanceRule.all.empty?
    InwRemittanceRule.seed do |s|
      s.pattern_salutations = "Mr\r\nMrs\r\nMiss\r\nDr\r\nMs\r\nPRof\r\nRev\r\nLady\r\nSir\r\nCapt\r\nMajor\r\nLtCol\r\nCol"
      s.approval_status = 'A'
    end
  end
end