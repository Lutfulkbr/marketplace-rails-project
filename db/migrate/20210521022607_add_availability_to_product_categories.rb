class AddAvailabilityToProductCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :product_categories, :availability, :string
  end
end
