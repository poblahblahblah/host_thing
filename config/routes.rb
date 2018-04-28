Rails.application.routes.draw do
  get 'home/index'

  resources :nodes do
    resources :comments
  end

  resources :statuses, :datacenters, :operating_systems, :roles, :software_apps, :macs, :ip_addrs, :interfaces

  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
