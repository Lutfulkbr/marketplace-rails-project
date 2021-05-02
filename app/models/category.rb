class Category < ApplicationRecord
    validates :title, presence: true, uniqueness: true

    has_many :product_categories
    has_many :products, through: :product_categories
    
end
