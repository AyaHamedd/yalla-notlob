class ItemsController < ApplicationController
    before_action :set_order, only: %i[ new create ]
    def new
        @item = @order.items.new
    end

    def create
        begin
            @item = @order.items.create(item_params)

            respond_to do |format|
                if @item.id == nil
                    format.turbo_stream { render turbo_stream: turbo_stream.replace(@item, partial: "items/form", locals: { item: @item}) }
                    format.html { render :new }
                    format.json { render json: @item.errors, status: unprocessable_entity }
                else
                    # format.turbo_stream
                    # format.turbo_stream do
                    #     render turbo_stream: turbo_stream.append(:items, partial: "items/item",
                    #       locals: { item: @item })
                    #     end
                    format.html { redirect_to @order }
                end
            end
        rescue => exception
            respond_to do |format|
                format.turbo_stream { render turbo_stream: turbo_stream.replace(@item, partial: "items/form", locals: { item: @item}) }
                format.html { render :new }
                format.json { render json: @item.errors, status: unprocessable_entity }
            end
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
