class AddDietaryRestrictions < ActiveRecord::Migration
  def change
    DietaryRestriction.create!(name: 'Fish free')
    DietaryRestriction.create!(name: 'Gluten free')
    DietaryRestriction.create!(name: 'Lactose free')
    DietaryRestriction.create!(name: 'Nut free')
    DietaryRestriction.create!(name: 'Vegetarian')
    DietaryRestriction.create!(name: 'None')
  end
end
