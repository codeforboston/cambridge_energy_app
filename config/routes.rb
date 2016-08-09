Rails.application.routes.draw do

  resources :user_tips
  resources :tips do
    member do
      get 'share'
    end
    collection do
      get 'next'
      get 'showdetails'
      get 'hidedetails'
    end
  end

  resources :bills do
    collection { get 'comparison' }
  end

  resources :teams, except: :destroy do
    member do
      get 'leave'
    end
    collection do
      get 'leaderboard'
    end
  end

  resources :units, only: [:show, :new, :create, :edit, :update] do
    member do
      patch 'leave'
    end
  end

  resources :user_buildings

  resources :uploads, only: [:new, :create, :show]

  # authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :invitations => 'users/invitations' }
  get '/auth/:provider/callback', to: 'sessions#create'

  get '/users/me', to: 'users#show'
  get '/users/me/edit', to: 'users#edit'
  patch '/users/me', to: 'users#update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  authenticated :user do
    root 'teams#leaderboard', as: :authenticated_root
  end

  # You can have the root of your site routed with "root"
  root 'bills#new'

  get 'graph/index'

  post 'teams/leaderboard' => 'teams#accept_or_decline'

  namespace :api do
    namespace :v1 do
      resources :addresses, only: [:index]
    end
  end

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
