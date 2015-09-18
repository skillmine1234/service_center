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
      post 'edit_multiple'
      put  'update_multiple'
    end
  end
  resources :udf_attributes
  resources :incoming_files
  resources :incoming_file_records
  resources :ecol_fetch_statistics
  resources :ecol_unapproved_records
  resources :inw_unapproved_records

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

  get '/inward_remittances/:id/remitter_identities' => 'inward_remittances#remitter_identities'
  get '/inward_remittances/:id/beneficiary_identities' => 'inward_remittances#beneficiary_identities'
  
  get '/download_attachment' => 'whitelisted_identities#download_attachment'
  
  get '/summary' => 'ecol_transactions#summary'
  
  get '/sdn/search' => 'aml_search#find_search_results'
  get '/sdn/search_results' => 'aml_search#results'
  get '/sdn/search_result' => 'aml_search#search_result'

  get '/inw_error_msg' => "inw_remittance_rules#error_msg"
  get '/ecol_error_msg' => "ecol_rules#error_msg"

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

  get '/ecol_transactions/:id/ecol_validations' => 'ecol_transactions#ecol_validations'
  get '/ecol_transactions/:id/ecol_notifications' => 'ecol_transactions#ecol_notifications'

  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end