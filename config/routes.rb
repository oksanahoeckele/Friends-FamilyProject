Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  # get 'auth/facebook', to: redirect
  delete '/signout', to: 'sessions#destroy'

   resources :books do
     resources :product_reviews
   end
   root 'books#index'
   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
