Rails.application.routes.draw do
  get 'pages/privacy'
  root to: 'posts#index'
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  get 'privacy', to: 'pages#privacy'
  get 'terms', to: 'pages#terms'
  get 'help', to: 'pages#help'
  get 'user_post', to: 'profiles#user_posts'
  get 'favorited_posts', to: 'profiles#favorited_posts'

  resources :users, only: %i[new create show]
  resources :posts do
    resources :time_schedules, only: %i[new create edit update destroy]
    resource :favorites, only: %i[create destroy]
    collection do
      get 'search'
    end
  end
  resource :profile, only: %i[show edit update]
end
