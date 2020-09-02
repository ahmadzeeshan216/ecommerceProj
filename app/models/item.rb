class Item < ApplicationRecord
    belongs_to :purchaseable, polymorphic: :true, optional: true
    belongs_to :product
    
    validate :cannot_add_own_product
    validate :stock_availability
    validates :quantity, numericality: {only_integer: true, greater_than: 0}

    protected

    def cannot_add_own_product
        if !purchaseable.nil? && product.user_id == purchaseable.user_id
            errors.add(:user , " can't add his/here own product into cart")
        end
    end

    def stock_availability
        errors.add(:stock , "have not enough products") if quantity > product.quantity
    end
end
