class CartItemsController < ApplicationController
    def create
        if !session[:cart]
            session[:cart]=Array.new
            if user_signed_in?
                @cart=current_user.build_cart
                @cart.save
                session[:cart_id]=@cart.id
            end
        end

        if user_signed_in?
            @cart=Cart.find session[:cart_id]
            @item=@cart.items.create(cart_item_params)
        else
            @item=Item.create(cart_item_params)
            
        end
    
        if !@item.errors.any?
            session[:cart].push(@item)
            flash.now[:message]="added to cart"
        end


        respond_to do |format|
            format.js { render :create}
            format.html
            format.json {render json: {r: "made"}}
        end
    end


    def index
        @list=Array.new
        @total= priceSum
        if session[:cart]
            hash=session[:cart]
            hash.each do |o|
                item=Item.new(o)
                @list.push(item)
            end
        end

    end

    def destroy
        @item = Item.find(params[:id])
        @item.destroy

        hash=session[:cart]
        hash.each do |o|
            if o.fetch("id") == @item.id
                session[:cart].delete(o)
            end
        end

        respond_to do |format|
            format.js { render :destroy}
            format.html
            format.json {render json: {r: "made"}}
        end
    end

    private

    def cart_item_params
        params.require(:item).permit(:product_id,:price,:quantity)
    end

    def priceSum
        sum=0
        if session[:cart]
            hash=session[:cart]
            hash.each do |o|
                sum=sum + ( o.fetch("price") * o.fetch("quantity") )
            end
        end
        sum
    end
end
