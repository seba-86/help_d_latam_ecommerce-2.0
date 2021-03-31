Rails.application.routes.draw do
  resource :cart, only: [:update, :show] do 
    member do 
      post :pay_with_paypal
      get :process_paypal_payment
    end
  end
  
  # get 'carts/show', to: "carts#show"
  # put 'carts/update', to: "carts#update", as: :cart
  
  devise_for :users
  devise_for :admins
  root "home#index"

  authenticate :admin do
    resources :products
    resources :categories
  end
    
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
