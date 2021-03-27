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
        @order = Order.new
    end

    def create
        @order = Order.create(order_params)
        users_in_group = []
        groups = get_invited_groups_param[:invited_groups]
        for group in groups[1..-1]
            group_id = group.to_i
            g = Group.find(group_id)
            for user in g.users
                users_in_group.push(user)
                @order.invited_users<<user
            end
        end

        friends = get_invited_friends_param[:invited_friends]

        for friend in friends[1..-1]
            friend_id = friend.to_i
            user = User.find(friend_id)
            unless users_in_group.include?(user) then @order.invited_users<<user end
        end

        respond_to do |format|
            # format.turbo_stream
            format.html { redirect_to @order }
        end
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

    private
    def order_params
        params.require(:order).permit(:order_type, :restaurant_name, :user_id).merge!(
            user_id: current_user.id,
            status: "waiting"
        )
    end

    def get_invited_friends_param
        params.require(:order).permit(invited_friends:[])
    end

    def get_invited_groups_param
        params.require(:order).permit(invited_groups:[])
    end
end
