Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  root to: "home#index"
  get "/home", to: "home#index"


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
end
