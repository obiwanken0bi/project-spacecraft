Rails.application.routes.draw do
  devise_for :users

  root to: 'spaceships#index'

  resources :spaceships do
    resources :bookings, only: [ :new, :create ]
    resources :reviews, only: [ :new, :create ]
  end

  resources :bookings, only: [ :show ]
  resources :users, only: [ :show, :edit, :update ]
end
