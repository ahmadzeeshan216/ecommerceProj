require 'stripe_service.rb'
class OrdersController < ApplicationController
	before_action :authenticate_user!, only:[:create]
		
	def create
		
		stripe_service = StripeService.new(params)
		stripe_service.charge
	
		if stripe_service.errors
			flash[:message] = stripe_service.errors
			redirect_to cart_items_path
		else
			create_order
		end
 	end

	private

    def order_params
        params.permit(:total_price,:payable_amount,:discount)
    end

    def delete_cart_session
		session.delete(:cart) if session[:cart]
	end
	
	def create_order
		@order=current_user.orders.build(order_params)
		
		#try using after_create callback here
		params[:ids].each do |id|
			@item = Item.includes(:product).find(id)
			product=@item.product
			@item.update(purchaseable: @order)
			product.update(quantity: product.quantity - @item.quantity)
		end

		if  !@order.errors.any?
			flash[:message] =" your order has been created"
			delete_cart_session
			@order.save
			redirect_to root_path  
		else
			flash[:message]=@item.errors.full_messages.to_s + @order.errors.full_messages.to_s
		end
	end
		
end