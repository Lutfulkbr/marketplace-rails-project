class CreateProductVariants < ActiveRecord::Migration[6.1]
  def change
    create_table :product_variants do |t|
      t.string :title, limit: 100, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :product_id

      t.timestamps
    end
  end
end
