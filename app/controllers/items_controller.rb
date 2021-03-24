class ItemsController < ApplicationController
    before_action :set_order, only: %i[ new create ]
    def new
        @item = @order.items.new
    end

    def create
        @order = Order.find(params[:order_id])
        if @order.status == "finished" or @order.status == "cancelled"
            puts "yes"
            redirect_to "/orders/closed_order"
        else
            @item = @order.items.create(item_params)

            respond_to do |format|
                if @item.id == nil
                    format.turbo_stream { render turbo_stream: turbo_stream.replace(@item, partial: "items/form", locals: { item: @item}) }
                    format.html { render :new }
                    format.json { render json: @item.errors, status: unprocessable_entity }
                else
                    # format.turbo_stream
                    format.html { redirect_to @order }
                end
            end
        end
    end

    def delete_item
        @order = Order.find(params[:order_id])
        @item = @order.items.find(params[:item_id])
        render :delete_item
    end

    def destroy
        @order = Order.find(params[:order_id])
        @item = @order.items.find(params[:id])
        @item.destroy if current_user.id == @item.user_id

        respond_to do |format|
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
