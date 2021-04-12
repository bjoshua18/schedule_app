# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'omniauth_callbacks/twitter'
  # Sign up, sign in
  controller :users do
    get 'signup' => :new
    get 'users' => :index
    post 'users' => :create
  end
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end

  # Callbacks
  get '/auth/twitter/callback', to: 'omniauth_callbacks#twitter'
  get '/auth/facebook/callback', to: 'omniauth_callbacks#facebook'

  resources :twitter_accounts
  resources :facebook_accounts do
    collection do
      get 'refresh_pages'
    end
  end
  resources :posts

  root 'home#index'
end
