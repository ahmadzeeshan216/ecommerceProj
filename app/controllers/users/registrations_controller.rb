class Users::RegistrationsController < Devise::RegistrationsController
   before_action :configure_sign_up_params, only: [:create]
 
   def create
      super
      return if !session[:cart] || !user_signed_in?
      cart = current_user.create_cart
      session[:cart]&.each { |hash_item| Item.find(hash_item["id"]).update(purchaseable: cart)} 
   end

  protected

   def configure_sign_up_params
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :phone, :address, :profile_picture])
   end

end
