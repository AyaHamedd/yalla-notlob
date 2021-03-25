class OrdersController < ApplicationController
    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def show
        @order = Order.find(params[:id])
        if @order.user_id == current_user.id
            render :show
        elsif @order.users.exists?(current_user.id)
            render :show
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

        respond_to do |format|
            # format.turbo_stream
            format.html { redirect_to orders_path }
        end
    end

    def cancel_order
        @order = Order.find(params[:order_id])
        if @order.status != "finished"
            @order.status = "cancelled"
            @order.save
        end

        respond_to do |format|
            # format.turbo_stream
            format.html { redirect_to orders_path }
        end
    end

    def closed_order
        render :closed_order
    end

    def joined_friends
        @order = Order.find(params[:id])
        @joined = @order.users
        render :joined_friends
    end

    def invited_friends
        @order = Order.find(params[:id])
        @invited = @order.invited_users
        render :invited_friends
    end
end
