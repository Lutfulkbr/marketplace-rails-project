class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.decimal :sub_total, precision: 8, scale: 2, null: false

      t.timestamps
    end
  end
end
