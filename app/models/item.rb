class Item < ApplicationRecord
    belongs_to :purchaseable, polymorphic: :true, optional: true
    belongs_to :product
    after_initialize :check_quantity
    validate :user_cannot_add_his_own_product_to_cart
    validates :quantity, numericality: { greater_than: 0 }

    def user_cannot_add_his_own_product_to_cart
        if !purchaseable.nil? && Product.find(product_id).user_id == purchaseable.user_id
            errors.add(:user , " can't add his/here own product into cart")
        end
    end

    def check_quantity
        if quantity==0
            errors.add(:quantity , " can't be zero")
        end
    end
end
