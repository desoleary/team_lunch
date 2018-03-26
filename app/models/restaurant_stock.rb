class RestaurantStock < ActiveRecord::Base
  belongs_to :restaurant
  belongs_to :stock

  validates :restaurant, :stock, presence: true
end
