unless Rails.env == 'production'
  if FpOperation.all.empty?
    FpOperation.seed(:operation_name,
      { operation_name: "validateCustomer", approval_status: 'A' },
      { operation_name: "inquireCustomerAccount", approval_status: 'A' },
      { operation_name: "inquireCASAMiniListOfTransaction", approval_status: 'A' },
      { operation_name: "inquireCasaAccountBalance", approval_status: 'A' },
      { operation_name: "inquireCASAStatementRequest", approval_status: 'A' },
      { operation_name: "requestChequeBook", approval_status: 'A' },
      { operation_name: "inquireCASAChequeStatus", approval_status: 'A' },
      { operation_name: "inquireTDAccounts", approval_status: 'A' },
      { operation_name: "inquireTDBalanceDetails", approval_status: 'A' },
      { operation_name: "inquireTDBalanceDetailsForDeposit", approval_status: 'A' },
      { operation_name: "inquireStopChequeDetails", approval_status: 'A' },
      { operation_name: "inquireStopChequeSeries", approval_status: 'A' },
      { operation_name: "fundsXferCASAToCASA", approval_status: 'A' },
      { operation_name: "fundsXferNEFT", approval_status: 'A' },
      { operation_name: "userLogin", approval_status: 'A' },
      { operation_name: "beneficiaryLibrary", approval_status: 'A' },
      { operation_name: "beneficiarySearch", approval_status: 'A' },
      { operation_name: "holdRequestForASBA", approval_status: 'A' },
      { operation_name: "deleteEarmarkASBA", approval_status: 'A' },
      { operation_name: "inquireCasaTdAccountBalance", approval_status: 'A' },
      { operation_name: "modifyEarmarkASBA", approval_status: 'A' },
      { operation_name: "custAsbaSignVerification", approval_status: 'A' },
      { operation_name: "FCDBUserPBKDF2RetailCheck", approval_status: 'A' },
      { operation_name: "FCDBUserPBKDF2CorpCheck", approval_status: 'A' },
      { operation_name: "fundsXferNEFT", approval_status: 'A' },
      { operation_name: "inquireTransactionStatus", approval_status: 'A' },
      { operation_name: "holdFundInquiry", approval_status: 'A' },
      { operation_name: "partialEarmarkFunds", approval_status: 'A' },
      { operation_name: "deleteEarmark", approval_status: 'A' },
      { operation_name: "miscCustomerCredit", approval_status: 'A' },
      { operation_name: "custSignVerification", approval_status: 'A' },
      { operation_name: "fundsXferFCATRTGS", approval_status: 'A' },
      { operation_name: "inquireBranchDetails", approval_status: 'A' },
      { operation_name: "inquireTDRDProducts", approval_status: 'A' },
      { operation_name: "inquireTDProductRates", approval_status: 'A' },
      { operation_name: "tdAccountOpeningPayin", approval_status: 'A' },
      { operation_name: "tdSetPayoutInstruction", approval_status: 'A' },
      { operation_name: "maintainSweepIn", approval_status: 'A' },
      { operation_name: "inquireRDProductRates", approval_status: 'A' },
      { operation_name: "rdAccountOpeningPayin", approval_status: 'A' },
      { operation_name: "inquireInstallmentPayment", approval_status: 'A' },
      { operation_name: "glToGlFundsXfer", approval_status: 'A' }
    )
  end
end