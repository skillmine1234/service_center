ServiceCenter::Application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :partners
  resources :purpose_codes

  get '/partner/:id/audit_logs' => 'partners#audit_logs'
  get '/purpose_code/:id/audit_logs' => 'purpose_codes#audit_logs'

  root :to => 'dashboard#overview'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  ActiveAdmin.routes(self)
end
