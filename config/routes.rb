Rails.application.routes.draw do
  root "teams#index"
  resources :divisions, only: [:index, :show]
  resources :teams, only: [:index, :show]
  resources :players, only: [:index, :show]
  get "about", to: "pages#about"
  get "up" => "rails/health#show", as: :rails_health_check
end