Rails.application.routes.draw do
  resources :users
  resources :epic_snapshots
  resources :epics

  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
