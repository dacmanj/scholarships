Scholarships::Application.routes.draw do
  resources :references


  resources :applications

  authenticated :user do
    root :to => 'home#index#index'
  end
  root :to => "home#index"

  devise_for :user, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  resources :users
  match '/references/send_email' => 'references#send_reference_request'
  match '/references/:id', to: 'references#resend', via: :post
  match '/references/token/:token' => 'references#edit'
 # match '/login' => "devise/sessions#new"

end