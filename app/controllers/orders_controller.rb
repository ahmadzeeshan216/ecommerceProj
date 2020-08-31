class OrdersController < ApplicationController
		before_action :authenticate_user!, only:[:create]
		
	def create
		#commute here again

		@amount = params[:payable_amount]

		token =	Stripe::Token.create({
			card: {
				number: params[:card_no],
				exp_month: 8,
				exp_year: 2021,
				cvc: params[:security_no],
			},
		})

		customer = Stripe::Customer.create({
			source: token,
		})
		
		charge = Stripe::Charge.create({
			customer: customer.id,
			amount: @amount,
			description: 'Rails Stripe customer',
			currency: 'usd',
		})

	rescue Stripe::CardError => e
		flash[:message] = e.message
		redirect_to cart_items_path
	else
		create_order

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
	
	def create_order
		@order=current_user.orders.build(orderParams)
		
		#try using after_create callback here
		params[:ids].each do |id|
			@item = Item.includes(:product).find(id)
			product=@item.product
			@item.update(purchaseable: @order)
			product.update(quantity: product.quantity - @item.quantity)
		end

		#fix this
		if !@item.errors.any? && !@order.errors.any?
			flash[:message] =" your order has been created"
			delteCartSeesion
			@order.save
			redirect_to root_path  
		else
			flash[:message]=@item.errors.full_messages.to_s + @order.errors.full_messages.to_s
		end
	end
		
end