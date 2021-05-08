class Product < ApplicationRecord
    attr_accessor :quantity
    
    validates :title, presence: true, uniqueness: true
    validates :price, presence: true

    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories

    scope :alpha_product, -> {order('title')}
    
end
