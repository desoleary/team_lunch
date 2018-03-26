class DietaryRestriction < ActiveRecord::Base
  validates :name, presence: true, length: { maximum: 50 }

  FISH_FREE = 'Fish free'
  GLUTEN_FREE = 'Gluten free'
  LACTOSE_FREE = 'Lactose free'
  NUT_FREE = 'Nut free'
  VEGETARIAN = 'Vegetarian'
  NONE = 'None'

  def self.fish_free
    @@dr_fish_free = DietaryRestriction.find_by(name: FISH_FREE)
  end

  def self.gluten_free
    @@dr_gluten_free = DietaryRestriction.find_by(name: GLUTEN_FREE)
  end

  def self.lactose_free
    @@dr_lactose_free = DietaryRestriction.find_by(name: LACTOSE_FREE)
  end

  def self.nut_free
    @@dr_nut_free = DietaryRestriction.find_by(name: NUT_FREE)
  end

  def self.vegetarian
    @@dr_vegetarian = DietaryRestriction.find_by(name: VEGETARIAN)
  end

  def self.none
    @@dr_none = DietaryRestriction.find_by(name: NONE)
  end
end
