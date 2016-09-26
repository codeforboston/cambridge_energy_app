Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  authenticated :user do
    root 'teams#leaderboard', as: :authenticated_root

    resources :bills, except: [:index, :new, :create] do
      collection { get 'comparison' }
    end

    resources :user_tips
    resources :tips do
      member do
        get 'share'
      end
      collection do
        get 'next'
        get 'like'
        get 'dislike'
      end
    end

    resources :teams, except: :destroy do
      member do
        get 'leave'
      end
      collection do
        get 'leaderboard'
      end
    end
    post 'teams/leaderboard' => 'teams#accept_or_decline'

    resources :units, only: [:show, :new, :create, :edit, :update] do
      member do
        patch 'leave'
      end
    end

    resources :uploads, only: [:new, :create, :show]

    resources :user_buildings

    get '/users/me', to: 'users#show'
    get '/users/me/edit', to: 'users#edit'
    patch '/users/me', to: 'users#update'

  end

  # You can have the root of your site routed with "root"
  # public
  root 'bills#new'

  # authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :invitations => 'users/invitations' }
  get '/auth/:provider/callback', to: 'sessions#create'

  resources :bills, only: [:index, :new, :create]
  get 'graph/index'

  namespace :api do
    namespace :v1 do
      resources :addresses, only: [:index]
    end
  end
end
