class HomeController < ApplicationController
  def index
    @orders = Order.where(user: current_user);
    @user = User.find(current_user.id)
    @activities = Friend.joins('INNER JOIN "orders" ON "orders"."user_id" = "friends"."friend_id"').where(users_id: current_user.id).order('"orders"."created_at" desc');
  end
end
