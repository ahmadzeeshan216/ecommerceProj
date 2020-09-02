require 'coupon.rb'

class CartItemsController < ApplicationController
	before_action :set_item, only: [:update, :destroy]
	before_action :set_price, only: [:index]

	def index
		@list=[]
		session[:cart]&.each { |item_id| @list << Item.find(item_id.to_s) }	
	end

	def create
		session[:cart] = [] if !session[:cart]
	
		if user_signed_in?
			@cart = current_user.cart
			@cart = current_user.create_cart if @cart.nil?
			@item=@cart.items.create(cart_item_params)
		else
			@item=Item.create(cart_item_params)
		end

		return if @item.errors.any?
		session[:cart].push(@item.id)
		flash.now[:message]="added to cart"
	end

	def update
		return if !@item.update(quantity: params[:quantity])
		flash.now[:message]="updated"
		set_price
	end

	def destroy
		return if !@item.destroy
		set_price
	end

	def apply_coupon
		if Coupon.all.key?(params[:coupon])
			@discountPercent = Coupon.all[params[:coupon]].to_f
			flash.now[:message]="Coupon applied, you have got discount of #{(@discountPercent * 100).to_s} percent"
		else
			@discountPercent=nil
			flash.now[:message]='Invalid coupon'
		end
	end

	private

	def set_item
		@item = Item.find(params[:id])
	end

	def cart_item_params
		params.require(:item).permit(:product_id,:price,:quantity)
	end

	def set_price
		@total = 0

		session[:cart]&.each do |item_id|
			item = Item.find(item_id.to_s)
			@total += item.price * item.quantity
		end
	end

end
