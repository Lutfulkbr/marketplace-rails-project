class Category < ApplicationRecord

    validates :title, presence: true, uniqueness: true

    has_many :product_categories, dependent: :destroy
    has_many :products, through: :product_categories

    scope :alpha_category, -> {order('title')}
    
end