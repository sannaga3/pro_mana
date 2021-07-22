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
  resources :bmis, except: :show
  resources :foods
  resources :nutrition_records do
    get 'my_daily', on: :member
  end
  resources :nutrition_record_lines, only: %i[destroy]
  resources :friendships, only: %i[create destroy]
  resources :contacts
  resources :replies, except: :show
  resources :top, only: %i[index]
  resources :user_guide, only: %i[index]
end
