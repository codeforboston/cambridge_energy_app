Rails.application.routes.draw do

  resources :invitations do
    member do
      get 'join'
    end
  end

  resources :bills do
    collection { get 'comparison' }
  end
  resources :teams, except: :destroy do
    member do
      get 'invite'
      get 'add'
      get 'inviting'
      get 'leave'
    end
    collection do
      get 'leaderboard'
    end
  end
  resources :units, only: [:show, :new, :create, :edit, :update]
  resources :user_buildings

  # authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  get '/auth/:provider/callback', to: 'sessions#create'

  get '/users/me', to: 'users#show'
  get '/users/me/edit', to: 'users#edit'
  patch '/users/me', to: 'users#update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'bills#new'

  get 'graph/index'

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
