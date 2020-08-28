class OrdersController < ApplicationController
    before_action :authenticate_user!, only:[:create]
    def create
        
		@amount = params[:payable_amount]

		Stripe.api_key = 'sk_test_51HL27CHCd5LMgwIM98sqapqsMkGNKIpGSC7rwTJrMqQw6VmvPanK5AQqxvvrsUmhkILkQ8bLuBDOGV6vESKB12iD00ofys5t9x'

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

		#rescue Stripe::CardError => e
		#	flash[:message] = e.message
		#	redirect_to cart_items_path
		#end
				
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
		
		params[:ids].each do |id|
			@item = Item.includes(:product).find(id)
			product=@item.product
			@item.update(purchaseable: @order)
			product.update(quantity: product.quantity - @item.quantity)
		end

		if !@item.errors.any? && !@order.errors.any?
			flash[:message] =" your order has been created"
			delteCartSeesion
			redirect_to root_path  
		else
			flash[:message]=@item.errors.full_messages.to_s + @order.errors.full_messages.to_s
		end
	end
		
end