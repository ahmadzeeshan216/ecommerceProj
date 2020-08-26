class Order < ApplicationRecord
    has_many :items, as: :purchaseable
    belongs_to :user
end
