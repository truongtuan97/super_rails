Rails.application.routes.draw do
  resources :posts
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    confirmations: 'users/confirmations'
  }
  root 'static_public#landing_page'

  get 'privacy', to: 'static_public#privacy'
  get 'terms', to: 'static_public#terms'

  resources :users, only: %i[index show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
