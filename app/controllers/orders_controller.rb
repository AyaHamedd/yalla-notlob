class OrdersController < ApplicationController
    def index
        @orders = Order.where(user_id: current_user.id)
    end

    def show
        begin
            @order = Order.find(params[:id])
            if @order.user_id == current_user.id
                render :show
            elsif @order.users.exists?(current_user.id)
                render :show
            else
                render :order_not_found
            end
        rescue => exception
            render :order_not_found
        end
    end

    def new
        @order = Order.new
    end

    def create
        friends = get_invited_friends_param[:invited_friends]
        groups = get_invited_groups_param[:invited_groups]

        @order = Order.new(order_params)
        users_invited = []
        for group in groups[1..-1]
            group_id = group.to_i
            g = Group.find(group_id)
            for user in g.users
                users_invited.push(user)
                @order.invited_users<<user
            end
        end

        for friend in friends[1..-1]
            friend_id = friend.to_i
            user = User.find(friend_id)
            unless
                users_invited.include?(user)
            then
                @order.invited_users<<user
                users_invited.push(user)
            end
        end

        if @order.save
            for invited_user in users_invited
                @notification = Notification.create(actor_id: @order.user_id, recipient_id: invited_user.id, action: "invited", order_id: @order.id)
            end

            respond_to do |format|
                # format.turbo_stream
                format.html { redirect_to @order }
            end
        else
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@order, partial: "orders/order_form", locals: { order: @order}) }
                format.html { render :new }
                # format.json { render json: @item.errors, status: unprocessable_entity }
            end
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

    def join_order
        begin
            @order = Order.find(params[:order_id])
            @invited_user = @order.invited_users.find(current_user.id)
            @order.invited_users.delete(@invited_user)

            @order.users<<current_user
            @order.save

            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@order, partial: "orders/order", locals: { order: @order}) }
                format.html { redirect_to @order }
            end
        rescue => exception
            render :order_not_found
        end
    end

    def view_restaurant_menu
        @order = Order.find(params[:order_id])
        render :restaurant_menu_for_order
    end

    def view_joined_orders
        @orders = current_user.orders
        render :view_joined_orders
    end

    private
    def order_params
        params.require(:order).permit(:order_type, :restaurant_name, :user_id, :restaurant_menu).merge!(
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
