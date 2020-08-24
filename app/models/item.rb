class Item < ApplicationRecord
    belongs_to :purchaseable, polymorphic: :true
end
