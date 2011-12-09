FuturePerfect::Application.routes.draw do
  root to: "sessions#new"
  devise_for :users
end
