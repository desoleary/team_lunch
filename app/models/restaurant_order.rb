class RestaurantOrder < ActiveRecord::Base
  belongs_to :order
  belongs_to :restaurant
  belongs_to :meals

  validates :order, :restaurant, presence: true
end
