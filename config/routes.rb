Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
  get "/home", to: "home#index"
# groups and friends routes
  get '/addGroup', :controller => 'groups', :action => 'add'
  post '/addGroup', :controller => 'groups', :action => 'addgroup'
  get '/addGroupMember', :controller => 'groups', :action => 'groupmember'
  post '/addMember' , :controller =>'groups' , :action =>'addmember'
  resources :groups
  resources :friends
  delete 'removemember/:id(.:format)', :to => 'groups#removemember'
  delete '/addFriend' , :to => 'friends#destroy'
  get '/addFriend' , :controller => 'friends', :action => 'add'
  post '/addFriend' , :controller =>'friends' , :action =>'addfriend'
# orders routes
  get "/orders/:id/joinedFriends", to: "orders#joined_friends", as: 'joined_friends'
  get "/orders/:id/invitedFriends", to: "orders#invited_friends", as: 'invited_friends'
  get "/orders/:order_id/items/:item_id/deleteItem", to: "items#delete_item", as: 'delete_item'
  get "/orders/:order_id/finish", to: "orders#finish_order", as: 'finish_order'
  get "/orders/:order_id/cancel", to: "orders#cancel_order", as: 'cancel_order'
  get "/orders/closed_order", to: "orders#closed_order", as: 'closed_order'

  resources :orders do
    resources :items
  end

  resources :notifications do
    collection do
      post :mark_as_read
      post :mark_as_recieved
    end
  end
end