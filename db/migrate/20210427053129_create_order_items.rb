class CreateOrderItems < ActiveRecord::Migration[6.1]
  def change
    create_table :order_items do |t|
      t.integer :quantity, null: false
      t.decimal :price, precision: 8, scale: 2, null: false
      t.integer :order_id
      t.integer :product_id

      t.timestamps
    end
  end
end
