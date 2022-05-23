require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do  
  get 'home', to: "homes#index"
  get 'err_page', to: "homes#err_page"

  constraints Clearance::Constraints::SignedIn.new do
    mount Sidekiq::Web, at: '/sidekiq'    
    root to: "homes#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "homes#index"
  end

  namespace :admin do
    resources :users
    resources :accounts    
    namespace :accounts do      
      get "actions/download_template", 
        to: "actions#download_template", 
        as: :download_template

      post 'actions/import',
          to: 'actions#import',
          as: :action_import
    end
    
    resources :general_transactions
    resources :journals
    namespace :journals do      
      post 'actions/import',
          to: 'actions#import',
          as: :action_import
          
      get "actions/download_template", 
          to: "actions#download_template", 
          as: :download_template
    end    
    
    resources :reports
    namespace :reports do      
      post 'actions/import',
          to: 'actions#import',
          as: :action_import
    end
  end
end
