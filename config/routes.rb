SocialThing::Application.routes.draw do

  resources :users do
    get 'feed', on: :member

    resources :friend_circles, only: [:index, :new, :create ]
    resources :posts, only: [:new, :create ]
  end

  resources :posts, except: [:index, :new, :create]
  resources :friend_circles, except: [:index, :new, :create]
  resource  :session, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
