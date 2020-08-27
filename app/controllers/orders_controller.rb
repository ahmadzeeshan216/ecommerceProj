class OrdersController < ApplicationController
    before_action :authenticate_user!, only:[:create]
    def create
        @order=current_user.orders.build(orderParams)
        params[:ids].each do |id|
            @item = Item.find(id)
            @item.purchaseable=@order
            @item.save
        end

        if !@item.errors.any? && !@order.errors.any?
           flash[:message] =" your order has been created"
           delteCartSeesion
           redirect_to root_path  
        else
            flash[:message]=@item.errors.full_messages.to_s + @order.errors.full_messages.to_s
        end
    end

private
    def orderParams
        params.permit(:total_price,:payable_amount,:discount)
    end

    def delteCartSeesion
        if session[:cart]
          session.delete(:cart)
         end
         if session[:cart_obj]
          session.delete(:cart_obj)
         end
    end
end
