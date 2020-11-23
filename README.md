Obdx reports Queries:-

-----------Bill Desk-CreditCard-----------------
SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" WHERE (payment_method = 'CreditCard' and biller_status IN ('SUCCESS','PENDING') OR biller_status IS NULL and trunc(req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and payment_status NOT IN ('SCHEDULED') and status IN ('BILLPAID','PENDING','MANUAL','DEBITED'))

-----------Bill Desk-BankAccount-----------------
SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" WHERE (payment_method = 'BankAccount' and biller_status IN ('SUCCESS','PENDING') OR biller_status IS NULL and trunc(req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and payment_status NOT IN ('SCHEDULED') and status IN ('BILLPAID','PENDING','MANUAL','DEBITED'))

-----------Bill Desk-Wallet-----------------
SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" WHERE (payment_method = 'Wallet' and biller_status IN ('SUCCESS','PENDING') OR biller_status IS NULL and trunc(req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and payment_status NOT IN ('SCHEDULED') and status IN ('BILLPAID','PENDING','MANUAL','DEBITED'))

-----------Wallet Business-----------------
SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" INNER JOIN "BM_BILLPAY_STEPS" ON "BM_BILLPAY_STEPS"."BM_BILL_PAYMENT_ID" = "BM_BILL_PAYMENTS"."ID" WHERE (bm_bill_payments.payment_method = 'Wallet' and trunc(bm_bill_payments.req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and bm_billpay_steps.step_name = 'BILLPAY' and bm_bill_payments.payment_status NOT IN ('SCHEDULED') and bm_bill_payments.status IN ('BILLPAID','PENDING','MANUAL','DEBITED','WALLET REVERSAL FAILED'))

----------Credit Card Business-----------------
SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" WHERE (payment_method = 'CreditCard' and trunc(req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and payment_status NOT IN ('SCHEDULED') and status IN ('BILLPAID','PENDING','MANUAL','DEBITED','CC PENDING DEBIT REVERSAL'))

-----------BankAccount Business-----------------
 SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" INNER JOIN "BM_BILLPAY_STEPS" ON "BM_BILLPAY_STEPS"."BM_BILL_PAYMENT_ID" = "BM_BILL_PAYMENTS"."ID" WHERE (bm_bill_payments.payment_method = 'BankAccount' and trunc(bm_bill_payments.req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and bm_billpay_steps.step_name = 'BILLPAY' and bm_bill_payments.payment_status NOT IN ('SCHEDULED') and bm_bill_payments.status IN ('BILLPAID','PENDING','MANUAL','DEBITED','FCR REVERSAL FAILED'))
OCIError: ORA-00904: "BM_BILL_PAYMENTS"."PAYMENT_STATUS": invalid identifier: SELECT "BM_BILL_PAYMENTS".* FROM "BM_BILL_PAYMENTS" INNER JOIN "BM_BILLPAY_STEPS" ON "BM_BILLPAY_STEPS"."BM_BILL_PAYMENT_ID" = "BM_BILL_PAYMENTS"."ID" WHERE (bm_bill_payments.payment_method = 'BankAccount' and trunc(bm_bill_payments.req_timestamp) BETWEEN '2020-01-01 00:00:00' and '2020-11-23 23:59:59' and bm_billpay_steps.step_name = 'BILLPAY' and bm_bill_payments.payment_status NOT IN ('SCHEDULED') and bm_bill_payments.status IN ('BILLPAID','PENDING','MANUAL','DEBITED','FCR REVERSAL FAILED'))