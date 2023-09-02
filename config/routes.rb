Rails.application.routes.draw do
  resources :users, only: [:index, :new, :create, :show]
  resources :tests
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
