Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "home#index"
  get "/home", to: "home#index"
  get "/orders/:id/joinedFriends", to: "orders#joined_friends"

  resources :orders do
    resources :items
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end
end