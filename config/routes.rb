FuturePerfect::Application.routes.draw do
  resources :goals, except: [:destroy]

  devise_for :users
  root to: 'goals#index'
end
