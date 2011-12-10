FuturePerfect::Application.routes.draw do

  resources :goals, except: [:destroy] do
    resources :progresses, only: [:new, :create]
  end

  devise_for :users
  root to: 'goals#index'
end
