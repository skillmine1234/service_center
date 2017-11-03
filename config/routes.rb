ServiceCenter::Application.routes.draw do

  mount Rp::Engine, at: '/rp'

  resources :encrypted_passwords
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :partners do
    member do
      put :resend_notification
    end
  end
  resources :purpose_codes
  resources :inward_remittances, except: :index do
    member do
      put 'release'      
    end
    collection do
      get :index
      put :index
    end
  end
  
  resources :whitelisted_identities, except: :index do
    member do
      put 'revoke'
      put 'ratify'
    end
    collection do
      get :index
      put :index
    end
  end

  resources :unapproved_records, only: :index
  
  resources :inw_remittance_rules
  resources :banks
  resources :iam_audit_rules
  
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
  resources :pc_apps
  resources :pc_programs
  resources :pc_products
  resources :pc2_apps do
    member do
      put :resend_notification
    end
  end
  resources :pc2_cust_accounts
  resources :pc_unapproved_records
  resources :pc_fee_rules

  resources :csv_exports
  resources :reconciled_returns
  resources :su_customers
  resources :su_unapproved_records
  resources :su_incoming_records
  resources :ic_incoming_records
  resources :pc_mm_cd_incoming_records
  resources :cn_incoming_records do
    member do
      get 'download_file'
    end
  end
  resources :cnb2_incoming_records, except: :index do
    member do
      get 'download_file'
    end
    collection do
      get :index
      post :index
    end
  end
  resources :rr_incoming_records
  resources :outgoing_files do
    member do
      get 'download_response_file'
    end
  end
  resources :ic_customers do
    member do
      put :resend_notification
    end
  end
  resources :ic_suppliers
  resources :ic_invoices
  resources :ic_unapproved_records

  resources :sm_banks do
    member do
      put :resend_notification
    end
  end

  resources :sm_bank_accounts
  resources :sm_unapproved_records

  resources :cn_unapproved_records
  resources :rr_unapproved_records
  
  resources :rc_transfer_schedules
  resources :rc_transfers, except: :index do
    collection do
      put  'update_multiple'
      get :index
      put :index
    end
    member do
      put :retry
    end
  end
  resources :rc_apps
  resources :rc_transfer_unapproved_records

  resources :sc_backends do
    member do
      post 'change_status'
    end
  end

  namespace :api do
    namespace :v1 do
      resources :whitelisted_identities
    end
  end
  
  resources :inw_guidelines
  resources :partner_lcy_rates

  resources :iam_cust_users, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      put :try_login
      put :add_user
      put :delete_user
      put :resend_password
    end
  end

  resources :iam_organisations, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      put :resend_notification
    end
  end
  
  resources :sc_backend_response_codes, except: :index do
    collection do
      get :index
      put :index
    end
  end
  
  resources :sc_fault_codes, except: :index do
    collection do
      get :index
      put :index
      get :get_fault_reason
    end
  end
  
  resources :iam_cust_users, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      get :connect_to_ldap
    end
  end

  resources :fr_r01_incoming_records, except: :index do
    collection do
      get :index
      post :index
    end
  end

  resources :ic001_incoming_records, except: :index do
    collection do
      get :index
      post :index
    end
  end

  resources :sc_jobs, except: :index do
    collection do
      get :index
      put :index
    end
    member do
      put :run
      put :pause
    end
  end
  
  resources :ns_callbacks do
    collection do
      get :index
      put :index
    end
    member do
      get 'audit_logs'
      put 'approve'
    end
  end

  resources :ns_templates do
    member do
      get 'audit_logs'
      put 'approve'
    end
  end

  resources :imt_incoming_records, except: :index do
    collection do
      get :index
      post :index
    end
  end
  
  resources :sc_backend_settings, except: :index do
    collection do
      get :index
      put :index
      get :get_service_codes
      get :settings
    end
    member do
      get 'audit_logs'
      put 'approve'
    end
  end 

  resources :iam_audit_logs, only: [:index, :show] do 
    collection do
      get :index
      put :index
    end
  end

  get 'su_incoming_file_summary' => 'su_incoming_records#incoming_file_summary'
  get 'ic_incoming_file_summary' => 'ic_incoming_records#incoming_file_summary'
  get 'pc_mm_cd_incoming_file_summary' => 'pc_mm_cd_incoming_records#incoming_file_summary'
  get 'cn_incoming_file_summary' => 'cn_incoming_records#incoming_file_summary'
  get 'cnb2_incoming_file_summary' => 'cnb2_incoming_records#incoming_file_summary'
  get 'fr_r01_incoming_file_summary' => 'fr_r01_incoming_records#incoming_file_summary'
  get 'rr_incoming_file_summary' => 'rr_incoming_records#incoming_file_summary'
  get 'override_records' => 'incoming_files#override_records'
  get 'incoming_files/:id/audit_steps/:step_name' => 'incoming_files#audit_steps'
  get 'incoming_file_records/:id/audit_steps/:step_name' => 'incoming_file_records#audit_steps'
  get 'rc_transfers/:id/audit_steps/:step_name' => 'rc_transfers#audit_steps'
  get '/su_incoming_records/:id/audit_logs' => 'su_incoming_records#audit_logs'
  get '/ic_incoming_records/:id/audit_logs' => 'ic_incoming_records#audit_logs'
  get '/pc_mm_cd_incoming_records/:id/audit_logs' => 'pc_mm_cd_incoming_records#audit_logs'
  get '/cn_incoming_records/:id/audit_logs' => 'cn_incoming_records#audit_logs'
  get '/cnb2_incoming_records/:id/audit_logs' => 'cnb2_incoming_records#audit_logs'
  get '/fr_r01_incoming_records/:id/audit_logs' => 'fr_r01_incoming_records#audit_logs'
  get '/rr_incoming_records/:id/audit_logs' => 'rr_incoming_records#audit_logs'
  get '/partner/:id/audit_logs' => 'partners#audit_logs'
  get '/purpose_code/:id/audit_logs' => 'purpose_codes#audit_logs'
  get '/inw_remittance_rule/:id/audit_logs' => 'inw_remittance_rules#audit_logs'
  get '/bank/:id/audit_logs' => 'banks#audit_logs'
  get '/iam_audit_rule/:id/audit_logs' => 'iam_audit_rules#audit_logs'
  get '/pc_app/:id/audit_logs' => 'pc_apps#audit_logs'
  get '/pc_program/:id/audit_logs' => 'pc_programs#audit_logs'
  get '/pc_product/:id/audit_logs' => 'pc_products#audit_logs'
  get '/pc2_app/:id/audit_logs' => 'pc2_apps#audit_logs'
  get '/pc2_cust_account/:id/audit_logs' => 'pc2_cust_accounts#audit_logs'
  get '/pc_fee_rule/:id/audit_logs' => 'pc_fee_rules#audit_logs'
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
  
  get '/sdn/search' => 'aml_search#find_search_results'
  get '/sdn/search_results' => 'aml_search#results'
  get '/sdn/search_result' => 'aml_search#search_result'

  get '/inw_error_msg' => "inw_remittance_rules#error_msg"
  get '/iam_audit_rule_error_msg' => "iam_audit_rules#error_msg"

  put '/incoming_file/:id/approve' => "incoming_files#approve"
  put '/partner/:id/approve' => "partners#approve"
  put '/purpose_code/:id/approve' => "purpose_codes#approve"
  put '/bank/:id/approve' => "banks#approve"
  put '/inw_remittance_rule/:id/approve' => "inw_remittance_rules#approve"
  put '/whitelisted_identity/:id/approve' => "whitelisted_identities#approve"
  
  put '/pc_app/:id/approve' => "pc_apps#approve"
  put '/pc_program/:id/approve' => "pc_programs#approve"
  put '/pc_product/:id/approve' => "pc_products#approve"
  put '/pc2_app/:id/approve' => "pc2_apps#approve"
  put '/pc2_cust_account/:id/approve' => "pc2_cust_accounts#approve"
  put '/pc_fee_rule/:id/approve' => "pc_fee_rules#approve"
  put '/su_customers/:id/approve' => "su_customers#approve"
  put '/ic_customers/:id/approve' => "ic_customers#approve"
  put '/ic_suppliers/:id/approve' => "ic_suppliers#approve"
  put '/sm_banks/:id/approve' => "sm_banks#approve"
  put '/sm_bank_accounts/:id/approve' => 'sm_bank_accounts#approve'
  put '/rc_transfer_schedules/:id/approve' => "rc_transfer_schedules#approve"
  put '/sc_backend/:id/approve' => "sc_backends#approve"

  get '/inward_remittances/:id/audit_logs/:step_name' => 'inward_remittances#audit_logs'

  get '/view_raw_content/:id' => "incoming_files#view_raw_content"
  
  get '/csv_export/download_csv' => 'csv_exports#download_csv'

  get '/pc_products/:id/encrypt_password' => 'pc_products#encrypt_password', as: :pc_products_encrypt_password
    
  get '/rc_apps/:id/audit_logs' => 'rc_apps#audit_logs'
  put '/rc_apps/:id/approve' => "rc_apps#approve"
  get '/rc_transfer_schedules/udfs/:rc_app_id' => 'rc_transfer_schedules#udfs'
  get '/inw_guidelines/:id/audit_logs' => 'inw_guidelines#audit_logs'
  put '/inw_guidelines/:id/approve' => "inw_guidelines#approve"
  get '/partner_lcy_rates/:id/audit_logs' => 'partner_lcy_rates#audit_logs'
  put '/partner_lcy_rates/:id/approve' => "partner_lcy_rates#approve"

  get '/iam_cust_users/:id/audit_logs' => 'iam_cust_users#audit_logs'
  put '/iam_cust_users/:id/approve' => "iam_cust_users#approve"
  get '/iam_organisations/:id/audit_logs' => 'iam_organisations#audit_logs'
  put '/iam_organisations/:id/approve' => "iam_organisations#approve"

  get '/sc_backend_response_codes/:id/audit_logs' => 'sc_backend_response_codes#audit_logs'
  put '/sc_backend_response_codes/:id/approve' => "sc_backend_response_codes#approve"
    
  get 'ic001_incoming_file_summary' => 'ic001_incoming_records#incoming_file_summary'
  get '/ic001_incoming_records/:id/audit_logs' => 'ic001_incoming_records#audit_logs'

  get 'imt_incoming_file_summary' => 'imt_incoming_records#incoming_file_summary'
  get '/imt_incoming_records/:id/audit_logs' => 'imt_incoming_records#audit_logs'
  
  get '/iam_cust_users/:id/audit_logs' => 'iam_cust_users#audit_logs'
  put '/iam_cust_users/:id/approve' => "iam_cust_users#approve"
  
  get '/version' => 'dashboard#version'
  get '/error_msg' => 'dashboard#error_msg'
  get 'dashboard/operations', as: :operations
  
  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end