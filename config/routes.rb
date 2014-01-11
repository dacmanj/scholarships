Scholarships::Application.routes.draw do
  resources :references


  resources :applications

  authenticated :user do
    root :to => 'home#index#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users
  match '/references/send_email' => 'references#send_reference_request'


end