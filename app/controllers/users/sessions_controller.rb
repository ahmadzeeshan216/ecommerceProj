class Users::SessionsController < Devise::SessionsController

  def create
    super
    return if !user_signed_in?
    @cart = current_user.cart
    map_session_items_to_cart
    delete_cart_session
    take_items_into_session
  end

  def destroy
    delete_cart_session
    super
  end

  private

  def take_items_into_session
    items = @cart&.items
    
    return if items.nil?

    session[:cart]=[] if !session[:cart]
    
    items.each do |item|
      session[:cart].push(item.id)
    end
  end

  def map_session_items_to_cart
    if session[:cart]
      @cart=current_user.build_cart if @cart.nil?
      
      session[:cart].each do |item_id|
        Item.find(item_id.to_s).update(purchaseable: @cart)
      end
    end
  end
  
  def delete_cart_session
    session.delete(:cart) if session[:cart]
  end

end
