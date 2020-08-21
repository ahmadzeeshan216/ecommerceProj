class Comment < ApplicationRecord

    belongs_to :product
    belongs_to :user
    validate :user_cannot_add_comment_to_his_own_product, on: :create
    validates :body, presence: true

    def user_cannot_add_comment_to_his_own_product
        if Product.find(product_id).user_id == user_id
            errors.add(:user , " can't comment on his/here own product")
        end
    end
end
