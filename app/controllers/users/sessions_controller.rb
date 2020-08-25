# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
     delteCartSeesion

     super
     cart = current_user.cart

     if !cart.nil?
      session[:cart_id]=cart.id
      items=cart.items
      if !items.nil?
        session[:cart]=Array.new
        items.each do |i|
          session[:cart].push(i)
        end
       end
     end

     

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

  def delteCartSeesion
    if session[:cart]
      session.delete(:cart)
     end
     puts ''
     if session[:cart_obj]
      session.delete(:cart_obj)
     end
  end
end
