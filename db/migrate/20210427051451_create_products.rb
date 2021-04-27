class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :title, limit: 100, null: false
      t.text :description
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0

      t.timestamps
    end
  end
end
