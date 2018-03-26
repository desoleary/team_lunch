class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.integer :quantity
      t.references :restaurant, index: true, foreign_key: true
      t.references :dietary_restriction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
