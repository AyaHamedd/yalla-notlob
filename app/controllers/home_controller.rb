class HomeController < ApplicationController
  def index
    @orders = Order.where(user: current_user).order('"orders"."created_at" desc');;
    @user = User.find(current_user.id)
    @activities = Friend.joins('INNER JOIN "orders" ON "orders"."user_id" = "friends"."friend_id"')
    .joins('INNER JOIN "users" ON "users"."id" = "friends"."friend_id"')
    .select("users.full_name","friends.friend_id","orders.id","orders.restaurant_name","orders.order_type","orders.created_at")
    .where(users_id: current_user.id)
    .order('"orders"."created_at" desc');
  end
end
