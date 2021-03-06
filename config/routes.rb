Scholarships::Application.routes.draw do
  resources :scores


  resources :references


  resources :applications do
    collection do
      post :edit_multiple
    end
  end

  match '/applications/:id/sign', to: 'applications#sign', as: :sign_application
  match '/applications/:id/unsign', to: 'applications#unsign', as: :unsign_application


  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }, :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  resources :users
  match '/references/send_email' => 'references#send_reference_request'
  match '/references/:id', to: 'references#resend', via: :post
  match '/references/token/:token' => 'references#edit'
  
 # match '/login' => "devise/sessions#new"

end