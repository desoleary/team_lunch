class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :order, index: true, foreign_key: true
      t.integer :quantity
      t.references :dietary_restriction, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
