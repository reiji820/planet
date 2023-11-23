Rails.application.routes.draw do
  root to: 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  resources :users, only: %i[new create]
  resources :posts do
    resources :time_schedules, only: %i[new create destroy]
  end
  resource :profile,only: %i[show edit update]
end
