class OrdersController < ApplicationController
    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def show
        @order = Order.find(params[:id])
        if @order.user_id == current_user.id
            return @order
        elsif @order.users.exists?(current_user.id)
            return @order
        else
            render :order_not_found
        end
    end

    def new
        render :new
    end

    def create
    end

    def edit
        @order = Order.find(params[:id])
    end

    def finish_order
        @order = Order.find(params[:order_id])
        if @order.status != "finished"
            @order.status = "finished"
            @order.save
        end
        redirect_to orders_path
    end

    def joined_friends
        @order = Order.find(params[:id])
        @joined = @order.users
        render :joined_friends
    end
end
