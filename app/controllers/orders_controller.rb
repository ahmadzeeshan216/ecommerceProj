class OrdersController < ApplicationController
    before_action :authenticate_user!, only:[:create]
    def create
        @order=current_user.orders.build(orderParams)
    end

private
    def orderParams
        params.permit(:total_price,:payable_amount,:discount)
    end
end
