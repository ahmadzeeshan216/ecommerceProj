class CartItemsController < ApplicationController
    def create
       
        

        if !session[:cart]
            session[:cart]=Array.new
            if user_signed_in?
                @cart=current_user.carts.create
                session[:cart_obj]=@cart
            end
        end

        if user_signed_in?
            @cart=session[:cart_obj]
            @item=@cart.item.create(cart_item_params)
        else
            @item=Items.new(cart_item_params)
        end
    
        session[:cart].push(@item)
        respond_to do |format|
            format.js { render :create}
            format.html
            format.json {render json: {r: "made"}}
        end
    end


    private

    def cart_item_params
        params.require(:item).permit(:product_id,:price,:quantity)
    end
end
