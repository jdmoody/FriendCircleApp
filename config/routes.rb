SocialThing::Application.routes.draw do
  resources :users
  resource  :session, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
