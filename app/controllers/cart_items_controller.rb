class CartItemsController < ApplicationController

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

    def create
        if !session[:cart]
            session[:cart]=Array.new
            if user_signed_in?
                @cart = current_user.cart
                @cart = current_user.build_cart if @cart.nil?
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

    def update
        @item=Item.find(params[:id])
        @item.update(quantity: params[:quantity])

        if !@item.errors.any?
            hash=session[:cart]
            hash.each do |o|
                if o.fetch("id") == @item.id
                    o["quantity"]=@item.quantity
                end
            end
            flash.now[:message]="updated"
        end
        @total = priceSum
        respond_to do |format|
            format.js { render :update}
            format.html
            format.json {render json: {r: "made"}}
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

        @total= priceSum

        respond_to do |format|
            format.js { render :destroy}
            format.html
            format.json {render json: {r: "made"}}
        end
    end

    def apply_coupon
        @coupons_hash = {'DEVSINC' => '.5', 'PAKARMY' => '.3'} 
        @key=params[:coupon]

        if @coupons_hash.key?(@key)
            @discountPercent=@coupons_hash[@key].to_f
            flash.now[:message]="Coupon applied, you have got discount of #{(@discountPercent * 100).to_s} percent"
        else
            @discountPercent=nil
            flash.now[:message]="Invalid coupon"
        end

        respond_to do |format|
            format.js { render :apply_coupon}
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
