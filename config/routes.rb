Rails.application.routes.draw do
  root to: "top#index"
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    post 'users/admin_guest_sign_in', to: 'users/sessions#new_admin_guest'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :users, only: [:index, :show]
  resources :bmis, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :foods
  resources :records do
    collection do
      get :my_daily
    end
  end
  resources :friendships, only: [:create, :destroy]
end
