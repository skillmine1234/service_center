ServiceCenter::Application.routes.draw do

  resources :encrypted_passwords
  resources :qg_ecol_todays_rtgs_txns
  resources :qg_ecol_todays_neft_txns
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :partners
  resources :purpose_codes
  resources :inward_remittances
  resources :whitelisted_identities
  resources :inw_remittance_rules
  resources :banks
  resources :ecol_rules
  resources :ecol_customers
  resources :ecol_remitters
  resources :ecol_transactions do
    collection do
      put  'update_multiple'
    end
  end
  resources :udf_attributes
  
  resources :incoming_files do
    member do
      get 'download_response_file'
      get 'generate_response_file'
      get 'approve_restart'
      get 'skip_all_records'
    end
  end
  
  resources :incoming_file_records
  resources :ecol_fetch_statistics
  resources :ecol_unapproved_records
  resources :inw_unapproved_records
  resources :bm_unapproved_records
  resources :bm_rules
  resources :bm_billers
  resources :bm_bill_payments
  resources :bm_aggregator_payments
  resources :bm_apps
  resources :pc_apps
  resources :pc2_apps
  resources :pc_unapproved_records
  resources :pc2_unapproved_records
  resources :pc_fee_rules
  resources :fp_unapproved_records
  resources :fp_operations
  resources :fp_auth_rules
  resources :imt_customers
  resources :imt_unapproved_records
  resources :imt_transfers
  resources :csv_exports
  resources :ft_unapproved_records
  resources :funds_transfer_customers
  resources :reconciled_returns
  resources :su_customers
  resources :su_unapproved_records
  resources :su_incoming_records
  resources :ic_incoming_records
  resources :outgoing_files do
    member do
      get 'download_response_file'
    end
  end
  resources :ic_customers
  resources :ic_suppliers
  resources :ic_invoices
  resources :ic_unapproved_records

  namespace :api do
    namespace :v1 do
      resources :whitelisted_identities
    end
  end

  get 'su_incoming_file_summary' => 'su_incoming_records#incoming_file_summary'
  get 'ic_incoming_file_summary' => 'ic_incoming_records#incoming_file_summary'
  get 'override_records' => 'incoming_files#override_records'
  get 'incoming_files/:id/audit_steps/:step_name' => 'incoming_files#audit_steps'
  get 'incoming_file_records/:id/audit_steps/:step_name' => 'incoming_file_records#audit_steps'
  get '/su_incoming_records/:id/audit_logs' => 'su_incoming_records#audit_logs'
  get '/ic_incoming_records/:id/audit_logs' => 'ic_incoming_records#audit_logs'
  get '/partner/:id/audit_logs' => 'partners#audit_logs'
  get '/purpose_code/:id/audit_logs' => 'purpose_codes#audit_logs'
  get '/inw_remittance_rule/:id/audit_logs' => 'inw_remittance_rules#audit_logs'
  get '/bank/:id/audit_logs' => 'banks#audit_logs'
  get '/ecol_rule/:id/audit_logs' => 'ecol_rules#audit_logs'
  get '/ecol_customer/:id/audit_logs' => 'ecol_customers#audit_logs'
  get '/ecol_remitter/:id/audit_logs' => 'ecol_remitters#audit_logs'
  get '/udf_attribute/:id/audit_logs' => 'udf_attributes#audit_logs'
  get '/bm_biller/:id/audit_logs' => 'bm_billers#audit_logs'
  get '/bm_rule/:id/audit_logs' => 'bm_rules#audit_logs'
  get '/bm_aggregator_payment/:id/audit_logs' => 'bm_aggregator_payments#audit_logs'
  get '/bm_app/:id/audit_logs' => 'bm_apps#audit_logs'
  get '/pc_app/:id/audit_logs' => 'pc_apps#audit_logs'
  get '/pc2_app/:id/audit_logs' => 'pc2_apps#audit_logs'
  get '/pc_fee_rule/:id/audit_logs' => 'pc_fee_rules#audit_logs'
  get '/fp_operation/:id/audit_logs' => 'fp_operations#audit_logs'
  get '/fp_auth_rule/:id/audit_logs' => 'fp_auth_rules#audit_logs'
  get '/imt_customer/:id/audit_logs' => 'imt_customers#audit_logs'
  get '/funds_transfer_customer/:id/audit_logs' => 'funds_transfer_customers#audit_logs'
  get '/reconciled_returns/:id/audit_logs' => 'reconciled_returns#audit_logs'
  get '/su_customers/:id/audit_logs' => 'su_customers#audit_logs'
  get '/ic_customers/:id/audit_logs' => 'ic_customers#audit_logs'
  get '/ic_suppliers/:id/audit_logs' => 'ic_suppliers#audit_logs'

  get '/inward_remittances/:id/remitter_identities' => 'inward_remittances#remitter_identities'
  get '/inward_remittances/:id/beneficiary_identities' => 'inward_remittances#beneficiary_identities'
  
  get '/download_attachment' => 'whitelisted_identities#download_attachment'
  
  get '/summary' => 'ecol_transactions#summary'
  get '/bm_bill_payments_summary' => 'bm_bill_payments#summary'
  
  get '/sdn/search' => 'aml_search#find_search_results'
  get '/sdn/search_results' => 'aml_search#results'
  get '/sdn/search_result' => 'aml_search#search_result'

  get '/inw_error_msg' => "inw_remittance_rules#error_msg"
  get '/ecol_error_msg' => "ecol_rules#error_msg"
  get '/bm_rule_error_msg' => "bm_rules#error_msg"

  put '/ecol_customer/:id/approve' => "ecol_customers#approve"
  put '/udf_attribute/:id/approve' => "udf_attributes#approve"
  put '/ecol_remitter/:id/approve' => "ecol_remitters#approve"
  put '/ecol_rule/:id/approve' => "ecol_rules#approve"
  put '/incoming_file/:id/approve' => "incoming_files#approve"
  put '/partner/:id/approve' => "partners#approve"
  put '/purpose_code/:id/approve' => "purpose_codes#approve"
  put '/bank/:id/approve' => "banks#approve"
  put '/inw_remittance_rule/:id/approve' => "inw_remittance_rules#approve"
  put '/whitelisted_identity/:id/approve' => "whitelisted_identities#approve"
  
  put '/bm_biller/:id/approve' => "bm_billers#approve"
  put '/bm_rule/:id/approve' => "bm_rules#approve"
  put '/bm_aggregator_payment/:id/approve' => "bm_aggregator_payments#approve"
  put '/bm_app/:id/approve' => "bm_apps#approve"
  put '/pc_app/:id/approve' => "pc_apps#approve"
  put '/pc2_app/:id/approve' => "pc2_apps#approve"
  put '/pc_fee_rule/:id/approve' => "pc_fee_rules#approve"
  put '/fp_operation/:id/approve' => "fp_operations#approve"
  put '/fp_auth_rule/:id/approve' => "fp_auth_rules#approve"
  put '/imt_customer/:id/approve' => "imt_customers#approve"
  put '/funds_transfer_customer/:id/approve' => "funds_transfer_customers#approve"
  put '/su_customers/:id/approve' => "su_customers#approve"
  put '/ic_customers/:id/approve' => "ic_customers#approve"
  put '/ic_suppliers/:id/approve' => "ic_suppliers#approve"

  get '/ecol_transactions/:id/ecol_audit_logs/:step_name' => 'ecol_transactions#ecol_audit_logs'
  put '/ecol_transactions/:id/approve' => "ecol_transactions#approve_transaction"

  get '/bm_bill_payments/:id/audit_logs/:step_name' => 'bm_bill_payments#audit_logs'
  get '/bm_aggregator_payment/hit_api/:id' => 'bm_aggregator_payments#hit_api', as: :hit_api

  get '/view_raw_content/:id' => "incoming_files#view_raw_content"
  
  get '/csv_export/download_csv' => 'csv_exports#download_csv'

  # get '/encrypted_passwords' => 'encrypted_passwords#index'
    
  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end