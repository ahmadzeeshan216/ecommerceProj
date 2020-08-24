class Cart < ApplicationRecord
    has_many :items, as: :purchaseable
    belongs_to :user
end
