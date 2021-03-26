class HomeController < ApplicationController
  def index
    @orders = Order.where(user: current_user);
  end
end
