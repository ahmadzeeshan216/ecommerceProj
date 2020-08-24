class Order < ApplicationRecord
    has_many :items, as: :purchaseable
end
