require 'sidekiq/web'
require 'sidekiq-scheduler/web'

Rails.application.routes.draw do
  #Authrization Login/Register
  get 'home', to: "homes#index"
  get 'err_page', to: "homes#err_page"

  constraints Clearance::Constraints::SignedIn.new do
    mount Sidekiq::Web, at: '/sidekiq'    
    root to: "homes#index", as: :signed_in_root
  end

  constraints Clearance::Constraints::SignedOut.new do
    root to: "homes#index"
  end

end
