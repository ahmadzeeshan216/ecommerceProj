class Product < ApplicationRecord
    validates :name, :description, :price, :quantity, presence: true
    validates :images, presence: true
    validates :price,:quantity, numericality: {only_integer: true}

    belongs_to :user
    has_many :comments 
    has_many_attached :images 
    has_many :items
    
    
end
