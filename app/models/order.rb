class Order < ActiveRecord::Base
  belongs_to :team
  has_many :meals
  accepts_nested_attributes_for :meals

  validates :team, presence: true
  validates :order_date, presence: true,
            :timeliness => {:on_or_after => lambda { Date.current }, :type => :date}

  after_validation :process_order

  def process_order
    return if errors.present?
    member_summaries = build_member_summaries
    new_meals = []

    Restaurant.order(rating: :desc).each do |restaurant|
      restaurant_order = restaurant.fulfill_order(self, member_summaries)

      restaurant_order[:meals].each do |new_meal|
        new_meals << new_meal
      end
      member_summaries =  restaurant_order[:remaining_order_summary]
    end

    self.meals = new_meals

    member_summaries.each do |member_summary|
      errors[:base] << "Missing #{member_summary[:quantity]} of #{member_summary[:dietary_restriction].name}"
    end


  end

  def build_member_summaries
    team.members.select('count(members.id) as quantity, dietary_restriction_id').
        includes(:dietary_restriction).
        group(:dietary_restriction_id).
        map { |member_summary| {dietary_restriction: member_summary.dietary_restriction, quantity: member_summary.quantity} }
  end
end
