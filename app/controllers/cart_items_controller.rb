require 'coupon.rb'

class CartItemsController < ApplicationController
	before_action :set_item, only: [:update, :destroy]
	before_action :compute_price_sum, only: [:index]

	def index
		@list=[]
		session[:cart]&.each { |hash_item| @list << Item.new(hash_item) }	
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
		session[:cart].push(@item)
		flash.now[:message]="added to cart"
	end

	def update
		return if !@item.update(quantity: params[:quantity])
		session[:cart]&.each { |hash_item| hash_item["quantity"] = @item.quantity if hash_item["id"] == @item.id } 
		flash.now[:message]="updated"
		compute_price_sum
	end

	def destroy
		return if !@item.destroy
		session[:cart]&.each { |hash_item| session[:cart].delete(hash_item) if hash_item["id"] == @item.id}	
		compute_price_sum
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

	def compute_price_sum
		@total = 0
		
		session[:cart]&.each { |hash_item| @total += hash_item["price"] * hash_item["quantity"]}	

		@total
	end

end
