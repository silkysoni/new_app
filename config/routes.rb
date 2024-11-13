Rails.application.routes.draw do

  direct :rails_blob do |blob|
    "/rails/active_storage/blobs/#{blob.signed_id}/#{blob.filename}"
  end

  get 'search', to: 'products#search', as: 'search_products'

  # post '/stripe/webhook', to: 'payments#webhook'

    post 'payments/webhook', to: 'payments#webhook'
  
  

  devise_for :users

  resources :users do
    patch 'users/:id/edit', to: 'users#edit'
  end

  root to: "products#index"

  get 'product_register', to:'products#new'
  post 'product_register' , to:'products#create'
  get 'product', to:'products#index'
  get 'product/:id', to:'products#show', as: 'products'
  get 'sub_categories', to: 'products#sub_categories'

 

  resources :cart_items
  resources :wishlist_items, only: [:index,:destroy,:create]
  resources :carts, only:[:index,:destroy,:create]

  resources :products do
    resources :reviews 
  end

  resources :users do
    resources :addresses, only: [:index, :new, :create]
  end

  resources :carts do
    member do
      get 'invoice'
    end
  end
  
  resources :payments

  get 'ordered_items', to: 'carts#ordered_items', as: 'ordered_items'


  resources :payments, only: [:new, :create] do
    collection do
      post :create
      get :success
      get :cancel
    end
  end
end
