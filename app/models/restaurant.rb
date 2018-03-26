class Restaurant < ActiveRecord::Base
  has_many :restaurant_stocks
  has_many :restaurant_orders
  has_many :stocks
  has_many :meals

  validates :name, presence: true, length: { maximum: 255 }
  validates :rating, presence: true, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 5}

  # Creates Restaurant order based on given request @order_summarises
  # @param order_summary in the form of a list of hashes e.g. [{dietary_restriction_id: 1, quantity: 20}, {dietary_restriction_id: 2, quantity: 10}]
  def fulfill_order(order, order_summarises)
    meals = []
    remaining_order_summary = []
    order_summarises.each do |order_summary|
      dietary_restriction = order_summary[:dietary_restriction]
      next if (order_quantity = order_summary[:quantity]).zero?
      restaurant_stock_quantity = (self.stocks.find_by(dietary_restriction: dietary_restriction).quantity) rescue 0
      restaurant_stock_quantity -= self.meals.joins(:order).where(restaurant: self, dietary_restriction: dietary_restriction).where('orders.order_date = ?', order.order_date).sum(:quantity)


      unless restaurant_stock_quantity.zero? || order_quantity.zero?
        new_meal = build_meal(dietary_restriction, order, order_quantity, order_summary, restaurant_stock_quantity)
        order_summary[:quantity] = order_quantity - new_meal.quantity
        meals << new_meal
      end
      remaining_order_summary << order_summary unless order_summary[:quantity].zero?
    end

    {
        meals: meals,
        remaining_order_summary: remaining_order_summary
    }
  end

  def build_meal(dietary_restriction, order, order_quantity, order_summary, restaurant_stock_quantity)
    amount = restaurant_stock_quantity > order_quantity ? order_quantity : restaurant_stock_quantity
    Meal.new(restaurant: self, order: order, dietary_restriction: dietary_restriction, quantity: amount)
  end
end
