Rails.application.routes.draw do
  devise_for :users, :controllers => {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  resources :foods
end
