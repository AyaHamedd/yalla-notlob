class ItemsController < ApplicationController
    before_action :set_order, only: %i[ new create ]
    def new
        @item = @order.items.new
    end

    def create
        @item = @order.items.create!(item_params)
        respond_to do |format|
            format.turbo_stream
            format.html { redirect_to @order }
        end
    end

    private
        def set_order
            @order = Order.find(params[:order_id])
        end

        def item_params
            params.require(:item).permit(:name, :price, :quantity, :user_id).merge!(
                user_id: current_user.id
            )
        end
end
