class OrdersController < ApplicationController
    def index
        @orders = Order.all
    end

    def show
        @order = Order.find(params[:id])
        if @order.users_id == current_user.id
            return @order
        elsif @order.users.exists?(current_user.id)
            return @order
        else
            render :order_not_found
        end
    end

    def new
    end

    def create
    end

    def edit
        @order = Order.find(params[:id])
    end

    def joined_friends
        render :joined_friends
    end
end
