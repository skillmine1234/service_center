ServiceCenter::Application.routes.draw do

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
  resources :incoming_files
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
  resources :pc_unapproved_records
  resources :pc_fee_rules

  namespace :api do
    namespace :v1 do
      resources :whitelisted_identities
    end
  end

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
  get '/pc_fee_rule/:id/audit_logs' => 'pc_fee_rules#audit_logs'

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
  put '/pc_fee_rule/:id/approve' => "pc_fee_rules#approve"

  get '/ecol_transactions/:id/ecol_audit_logs/:step_name' => 'ecol_transactions#ecol_audit_logs'
  put '/ecol_transactions/:id/approve' => "ecol_transactions#approve_transaction"

  get '/bm_bill_payments/:id/audit_logs/:step_name' => 'bm_bill_payments#audit_logs'
  get '/bm_aggregator_payment/hit_api/:id' => 'bm_aggregator_payments#hit_api', as: :hit_api

  get '/view_raw_content/:id' => "incoming_files#view_raw_content"
  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end