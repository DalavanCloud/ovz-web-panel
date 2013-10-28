OWP::Application.routes.draw do
  match '/logout' => 'sessions#destroy', :as => :logout
  match '/login' => 'sessions#new', :as => :login
  match '/restore-password' => 'sessions#restore_password', :as => :restore_password
  match '/reset-password' => 'sessions#reset_password', :as => :reset_password
  resource :session
  namespace :admin do
      match '/hardware-servers/:action' => 'hardware_servers#index'
      match '/virtual-servers/:action' => 'virtual_servers#index'
      match '/server-templates/:action' => 'server_templates#index'
      match '/os-templates/:action' => 'os_templates#index'
      match '/event-log/:action' => 'event_log#index'
      match '/ip-addresses/:action' => 'ip_addresses#index'
      match '/ip-pools/:action' => 'ip_pools#index'
  end

  match ':controller/:action' => '#index'
  root :to => 'sessions#new'
  #match '*anything' => 'sessions#new'
end
