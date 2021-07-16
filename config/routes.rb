Rails.application.routes.draw do
  root to: 'top#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :users, only: %i[index show]
  resources :bmis, only: %i[index new create edit update destroy]
  resources :foods
  resources :nutrition_records do
    collection do
      get :my_daily
    end
  end
  resources :nutrition_record_lines, only: %i[destroy]
  resources :friendships, only: %i[create destroy]
  resources :contacts
  resources :replies, only: %i[index new create edit update destroy]
  resources :top, only: %i[index] do
    collection do
      get :user_guide
    end
  end
end
