Rails.application.routes.draw do
  root 'pages#home'

  namespace :users do
    get 'signup', to: 'sessions#new'
    post 'signup', to: 'sessions#create'

    get 'login', to: 'sessions#sign_in'
    post 'login', to: 'sessions#login_in'
  end
end
