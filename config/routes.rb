Rails.application.routes.draw do
  devise_scope :user do
    get "/sign_in" => "devise/sessions#new" # custom path to login/sign_in
    get "/sign_up", to: redirect('home#index')
  end

  devise_for :users, :skip => [:registrations] 
  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'
    put 'users' => 'devise/registrations#update', :as => 'user_registration'
  end

  get 'home/index'

  resources :nodes do
    resources :comments
  end

  resources :statuses, :datacenters, :operating_systems, :roles, :software_apps, :macs, :ip_addrs, :interfaces

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
