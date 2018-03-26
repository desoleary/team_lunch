class CreateRestaurantStocks < ActiveRecord::Migration
  def change
    create_table :restaurant_stocks do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :stock, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
