class Product < ApplicationRecord
	validates :name, :description, :price, :quantity, presence: true
	validates :images, presence: true
	validates :price,:quantity, numericality: {only_integer: true}
	
	before_validation :add_serial_number

	belongs_to :user
	has_many :comments 
	has_many_attached :images 
	has_many :items, dependent: :delete_all 
	
	def add_serial_number
		self.serial_number = SecureRandom.uuid
	end
	
end
