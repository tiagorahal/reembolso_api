Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:registrations]
  
  devise_for :users, skip: [:sessions, :registrations]

  resources :reembolsos, only: %i[index show create update destroy]
  resources :tags, only: %i[index create]

  root "reembolsos#index"
end
