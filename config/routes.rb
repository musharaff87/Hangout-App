Rails.application.routes.draw do
  get 'users/show'
  resources :rooms do
    resources :messages
  end


  #devise_for :users

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  #get 'home/index'
  #root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_scope :user do
    #get 'users', to: 'devise/session#new'
    get '/users/sign_out', to: 'devise/sessions#destroy'
  end
  root to: "welcome#index"
  get "/feed", to: "feed#feedpage"
  get "/chats", to: "rooms#index"
  #get "/profile", to: "profile#profilepage"
  #get "/users/signout", to: "welcome#index"

  resources :posts, only: [:index, :new, :create]

  get '/friends', to: 'friends#index'

  resources :friends, only: [:index, :create] do
    member do
      patch :accept
      delete :decline
    end
  end

  get 'user/:id', to: 'users#show', as: 'user'


 

end
