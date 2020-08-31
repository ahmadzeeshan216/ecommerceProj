# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create

    super
    @cart = current_user.cart

    map_session_items_to_cart
    delteCartSeesion
    take_items_into_session
  
   end

  # DELETE /resource/sign_out
   def destroy
    delteCartSeesion
    super
   end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  private

  def take_items_into_session
    items = @cart&.items
    
    return if items.nil?

    if !session[:cart]
      session[:cart]=Array.new
      session[:cart_id]=@cart.id
    end
    
    items.each do |i|
      session[:cart].push(i)
    end
  end

  def map_session_items_to_cart
    if session[:cart]
      hash=session[:cart]
      if @cart.nil?
        @cart=current_user.build_cart
      end
      hash.each do |o|
        Item.find(o['id']).update(purchaseable: @cart)
      end
    end
  end
  
  def delteCartSeesion # correct these spellings
    if session[:cart]
      session.delete(:cart)
     end

     if session[:cart_obj]
      session.delete(:cart_obj) # review here
     end
  end

end
