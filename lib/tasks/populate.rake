require 'faker'

namespace :db do

  desc "Erase and fill database"
  task :populate => :environment do
    ActiveRecord::Base.transaction do

      Stock.delete_all
      Restaurant.delete_all
      Member.delete_all
      Team.delete_all
      Order.delete_all

      team = Team.create(name: Faker::Company.name)

      (1..5).each do | |
        Member.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      dietary_restriction: DietaryRestriction.vegetarian,
                      team: team)
      end

      (1..7).each do | |
        Member.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      dietary_restriction: DietaryRestriction.gluten_free,
                      team: team)
      end

      (1..38).each do | |
        Member.create(first_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      dietary_restriction: DietaryRestriction.none,
                      team: team)
      end

      restaurant_a = Restaurant.create(name: Faker::Company.name,
                                       rating: 5)

      Stock.create(restaurant: restaurant_a,
                   quantity: 4,
                   dietary_restriction: DietaryRestriction.vegetarian)

      Stock.create(restaurant: restaurant_a,
                   quantity: 36,
                   dietary_restriction: DietaryRestriction.none)

      restaurant_b = Restaurant.create(name: Faker::Company.name,
                                       rating: 3)

      Stock.create(restaurant: restaurant_b,
                   quantity: 20,
                   dietary_restriction: DietaryRestriction.vegetarian)

      Stock.create(restaurant: restaurant_b,
                   quantity: 20,
                   dietary_restriction: DietaryRestriction.gluten_free)

      Stock.create(restaurant: restaurant_b,
                   quantity: 60,
                   dietary_restriction: DietaryRestriction.none)

    end
  end
end