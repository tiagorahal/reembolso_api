Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations"
  }

  resources :reembolsos, only: %i[index show create update destroy]
  resources :tags, only: %i[index create]

  root "reembolsos#index"
end
