class Meal < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :order
  belongs_to :dietary_restriction

  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 1}
  validates :order, :restaurant, presence: true
  validates :dietary_restriction, presence: true, uniqueness: { scope: [:restaurant, :order] }
end
