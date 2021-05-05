class Product < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :price, presence: true, uniqueness: true

    has_many :product_categories
    has_many :categories, through: :product_categories
    
end
