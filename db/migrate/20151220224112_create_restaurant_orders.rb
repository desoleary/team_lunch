class CreateRestaurantOrders < ActiveRecord::Migration
  def change
    create_table :restaurant_orders do |t|
      t.references :order, index: true, foreign_key: true
      t.references :restaurant, index: true, foreign_key: true
      t.references :meal, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
