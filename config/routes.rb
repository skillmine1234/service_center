ServiceCenter::Application.routes.draw do

  mount Rp::Engine, at: '/rp'

  resources :encrypted_passwords
  resources :qg_ecol_todays_rtgs_txns
  resources :qg_ecol_todays_neft_txns
  resources :qg_ecol_todays_imps_txns
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :partners
  resources :purpose_codes
  resources :inward_remittances, except: :index do
    member do
      put 'release'      
    end
    collection do
      get :index
      post :index
    end
  end
  
  resources :whitelisted_identities do
    member do
      put 'revoke'
      put 'ratify'
    end
  end
  
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
      get 'download_file'
      get 'generate_response_file'
      get 'approve_restart'
      get 'skip_records'
      get 'reject'
      get 'process_file'
      get 'reset'
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
  resources :pc_programs
  resources :pc_products
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
  resources :ft_purpose_codes
  resources :ft_customer_accounts
  resources :reconciled_returns
  resources :su_customers
  resources :su_unapproved_records
  resources :su_incoming_records
  resources :ic_incoming_records
  resources :ft_incoming_records
  resources :pc_mm_cd_incoming_records
  resources :cn_incoming_records
  resources :rr_incoming_records
  resources :outgoing_files do
    member do
      get 'download_response_file'
    end
  end
  resources :ic_customers
  resources :ic_suppliers
  resources :ic_invoices
  resources :ic_unapproved_records

  resources :sm_banks
  resources :sm_bank_accounts
  resources :sm_unapproved_records

  resources :cn_unapproved_records
  resources :rr_unapproved_records
  
  resources :rc_transfer_schedules
  resources :rc_transfers do
    collection do
      put  'update_multiple'
    end
  end
  resources :rc_apps
  resources :rc_transfer_unapproved_records

  resources :sc_backends do
    member do
      post 'change_status'
    end
  end
  resources :sc_unapproved_records

  namespace :api do
    namespace :v1 do
      resources :whitelisted_identities
    end
  end
  
  resources :inw_guidelines
  resources :ecol_apps
  resources :partner_lcy_rates

  get 'su_incoming_file_summary' => 'su_incoming_records#incoming_file_summary'
  get 'ic_incoming_file_summary' => 'ic_incoming_records#incoming_file_summary'
  get 'ft_incoming_file_summary' => 'ft_incoming_records#incoming_file_summary'
  get 'pc_mm_cd_incoming_file_summary' => 'pc_mm_cd_incoming_records#incoming_file_summary'
  get 'cn_incoming_file_summary' => 'cn_incoming_records#incoming_file_summary'
  get 'rr_incoming_file_summary' => 'rr_incoming_records#incoming_file_summary'
  get 'override_records' => 'incoming_files#override_records'
  get 'incoming_files/:id/audit_steps/:step_name' => 'incoming_files#audit_steps'
  get 'incoming_file_records/:id/audit_steps/:step_name' => 'incoming_file_records#audit_steps'
  get 'rc_transfers/:id/audit_steps/:step_name' => 'rc_transfers#audit_steps'
  get '/su_incoming_records/:id/audit_logs' => 'su_incoming_records#audit_logs'
  get '/ic_incoming_records/:id/audit_logs' => 'ic_incoming_records#audit_logs'
  get '/ft_incoming_records/:id/audit_logs' => 'ft_incoming_records#audit_logs'
  get '/pc_mm_cd_incoming_records/:id/audit_logs' => 'pc_mm_cd_incoming_records#audit_logs'
  get '/cn_incoming_records/:id/audit_logs' => 'cn_incoming_records#audit_logs'
  get '/rr_incoming_records/:id/audit_logs' => 'rr_incoming_records#audit_logs'
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
  get '/pc_program/:id/audit_logs' => 'pc_programs#audit_logs'
  get '/pc_product/:id/audit_logs' => 'pc_products#audit_logs'
  get '/pc2_app/:id/audit_logs' => 'pc2_apps#audit_logs'
  get '/pc_fee_rule/:id/audit_logs' => 'pc_fee_rules#audit_logs'
  get '/fp_operation/:id/audit_logs' => 'fp_operations#audit_logs'
  get '/fp_auth_rule/:id/audit_logs' => 'fp_auth_rules#audit_logs'
  get '/imt_customer/:id/audit_logs' => 'imt_customers#audit_logs'
  get '/funds_transfer_customer/:id/audit_logs' => 'funds_transfer_customers#audit_logs'
  get '/ft_purpose_code/:id/audit_logs' => 'ft_purpose_codes#audit_logs'
  get '/ft_customer_account/:id/audit_logs' => 'ft_customer_accounts#audit_logs'
  get '/reconciled_returns/:id/audit_logs' => 'reconciled_returns#audit_logs'
  get '/su_customers/:id/audit_logs' => 'su_customers#audit_logs'
  get '/ic_customers/:id/audit_logs' => 'ic_customers#audit_logs'
  get '/ic_suppliers/:id/audit_logs' => 'ic_suppliers#audit_logs'
  get '/sm_banks/:id/audit_logs' => 'sm_banks#audit_logs'
  get '/sm_bank_accounts/:id/audit_logs' => 'sm_bank_accounts#audit_logs'
  get '/rc_transfer_schedules/:id/audit_logs' => 'rc_transfer_schedules#audit_logs'
  get '/sc_backend/:id/audit_logs' => 'sc_backends#audit_logs'
  get '/whitelisted_identity/:id/audit_logs' => 'whitelisted_identities#audit_logs'
  get '/sc_backend/:id/previous_status_changes' => 'sc_backends#previous_status_changes', as: :previous_status_changes

  get '/inward_remittances/:id/identity/:id_id' => 'inward_remittances#identity'
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
  put '/pc_program/:id/approve' => "pc_programs#approve"
  put '/pc_product/:id/approve' => "pc_products#approve"
  put '/pc2_app/:id/approve' => "pc2_apps#approve"
  put '/pc_fee_rule/:id/approve' => "pc_fee_rules#approve"
  put '/fp_operation/:id/approve' => "fp_operations#approve"
  put '/fp_auth_rule/:id/approve' => "fp_auth_rules#approve"
  put '/imt_customer/:id/approve' => "imt_customers#approve"
  put '/funds_transfer_customer/:id/approve' => "funds_transfer_customers#approve"
  put '/ft_purpose_code/:id/approve' => "ft_purpose_codes#approve"
  put '/ft_customer_account/:id/approve' => "ft_customer_accounts#approve"
  put '/su_customers/:id/approve' => "su_customers#approve"
  put '/ic_customers/:id/approve' => "ic_customers#approve"
  put '/ic_suppliers/:id/approve' => "ic_suppliers#approve"
  put '/sm_banks/:id/approve' => "sm_banks#approve"
  put '/sm_bank_accounts/:id/approve' => 'sm_bank_accounts#approve'
  put '/rc_transfer_schedules/:id/approve' => "rc_transfer_schedules#approve"
  put '/sc_backend/:id/approve' => "sc_backends#approve"

  get '/ecol_transactions/:id/ecol_audit_logs/:step_name' => 'ecol_transactions#ecol_audit_logs'
  put '/ecol_transactions/:id/approve' => "ecol_transactions#approve_transaction"

  get '/inward_remittances/:id/audit_logs/:step_name' => 'inward_remittances#audit_logs'

  get '/bm_bill_payments/:id/audit_logs/:step_name' => 'bm_bill_payments#audit_logs'
  get '/bm_aggregator_payment/hit_api/:id' => 'bm_aggregator_payments#hit_api', as: :hit_api

  get '/view_raw_content/:id' => "incoming_files#view_raw_content"
  
  get '/csv_export/download_csv' => 'csv_exports#download_csv'

  get '/pc_products/:id/encrypt_password' => 'pc_products#encrypt_password', as: :pc_products_encrypt_password
    
  get '/rc_apps/:id/audit_logs' => 'rc_apps#audit_logs'
  put '/rc_apps/:id/approve' => "rc_apps#approve"
  get '/rc_transfer_schedules/udfs/:rc_app_id' => 'rc_transfer_schedules#udfs'
  get '/inw_guidelines/:id/audit_logs' => 'inw_guidelines#audit_logs'
  put '/inw_guidelines/:id/approve' => "inw_guidelines#approve"
  get '/ecol_apps/:id/audit_logs' => 'ecol_apps#audit_logs'
  put '/ecol_apps/:id/approve' => "ecol_apps#approve"
  get '/partner_lcy_rates/:id/audit_logs' => 'partner_lcy_rates#audit_logs'
  put '/partner_lcy_rates/:id/approve' => "partner_lcy_rates#approve"
  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end