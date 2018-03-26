require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { create(:order) }
  let(:team) { order.team }

  context '#team valid?' do
    it 'handles no team' do
      order.team = nil

      expect(order.valid?).to be_falsey
      expect(order.errors.count).to eql(1)
      expect(order.errors.full_messages.first).to eql("Team can't be blank")
    end

    it 'handle team' do
      new_team = order.team.dup
      new_team.name = 'new team'

      order.team = new_team

      expect(order.valid?).to be_truthy
    end
  end

  context '#order date valid?' do
    it 'handles no order date' do
      order.order_date = nil

      expect(order.valid?).to be_falsey
      expect(order.errors.count).to eql(2)
      expect(order.errors.full_messages.first).to eql("Order date can't be blank")
      expect(order.errors.full_messages.second).to eql('Order date is not a valid date')
    end

    it 'handles order date in past' do
      order.order_date = Date.yesterday

      expect(order.valid?).to be_falsey
      expect(order.errors.count).to eql(1)
      expect(order.errors.full_messages.first).to eql("Order date must be on or after #{Date.current}")
    end

    it 'handles order date today' do
      order.order_date = Date.current

      expect(order.valid?).to be_truthy
    end

    it 'handles order date tomorrow' do
      order.order_date = Date.tomorrow

      expect(order.valid?).to be_truthy
    end
  end

  context '#process_order' do
    let(:restaurant_a) { create(:restaurant, name: 'Restaurant A') }
    let(:restaurant_b) { create(:restaurant, name: 'Restaurant B') }

    before(:each) do
      ActiveRecord::Base.transaction do
        create_example_stock(restaurant_a, [ {dietary_restriction: DietaryRestriction.vegetarian, quantity: 4},
                                             {dietary_restriction: DietaryRestriction.none, quantity: 36}]
        )
        create_example_stock(restaurant_b, [ {dietary_restriction: DietaryRestriction.vegetarian, quantity: 20},
                                             {dietary_restriction: DietaryRestriction.gluten_free, quantity: 20},
                                             {dietary_restriction: DietaryRestriction.none, quantity: 60}])

        create_example_members(team, [ {dietary_restriction: DietaryRestriction.vegetarian, quantity: 5},
                                       {dietary_restriction: DietaryRestriction.gluten_free, quantity: 7},
                                       {dietary_restriction: DietaryRestriction.none, quantity: 38}])


        end
    end

    it 'creates the example order' do
      expect(order.valid?).to be_truthy
      expect(restaurant_a.meals.count).to eql(2)
      expect(restaurant_a.meals.find_by(dietary_restriction: DietaryRestriction.vegetarian).quantity).to eql(4)
      expect(restaurant_a.meals.find_by(dietary_restriction: DietaryRestriction.none).quantity).to eql(36)

      expect(restaurant_b.meals.count).to eql(3)
      expect(restaurant_b.meals.find_by(dietary_restriction: DietaryRestriction.vegetarian).quantity).to eql(1)
      expect(restaurant_b.meals.find_by(dietary_restriction: DietaryRestriction.gluten_free).quantity).to eql(7)
      expect(restaurant_b.meals.find_by(dietary_restriction: DietaryRestriction.none).quantity).to eql(2)
    end

    it 'creates the second order' do
      expect(order.valid?).to be_truthy
      expect(order.meals.count).to eql(5)

      order2 = build(:order, team: order.team)

      expect(order2.save!).to be_truthy
      expect(order2.reload.meals.count).to eql(3)

      expect(restaurant_b.meals.count).to eql(6)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.vegetarian).sum(:quantity)).to eql(6)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.gluten_free).sum(:quantity)).to eql(14)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.none).sum(:quantity)).to eql(40)
    end

    it 'creates the third order' do
      expect(order.valid?).to be_truthy
      expect(order.meals.count).to eql(5)

      order2 = build(:order, team: order.team)

      expect(order2.save!).to be_truthy
      expect(order2.reload.meals.count).to eql(3)
      expect(restaurant_b.meals.count).to eql(6)

      order3 = build(:order, team: order.team)
      expect(order3.save).to be_falsey
      expect(order3.errors.count).to eql(2)
      expect(order3.errors.full_messages.first).to eql('Missing 1 of Gluten free')
      expect(order3.errors.full_messages.second).to eql('Missing 18 of None')
    end

    it 'creates two orders on different days' do
      expect(order.valid?).to be_truthy
      expect(order.meals.count).to eql(5)

      order2 = build(:order, team: order.team)

      expect(order2.save!).to be_truthy
      expect(order2.reload.meals.count).to eql(3)
      expect(restaurant_b.meals.count).to eql(6)

      order3 = build(:order, team: order.team, order_date: Date.tomorrow)
      expect(order3.save!).to be_truthy

      expect(order3.valid?).to be_truthy
      expect(restaurant_a.meals.count).to eql(4)

      expect(restaurant_a.meals.where(dietary_restriction: DietaryRestriction.vegetarian).sum(:quantity)).to eql(8)
      expect(restaurant_a.meals.where(dietary_restriction: DietaryRestriction.none).sum(:quantity)).to eql(72)

      expect(restaurant_b.meals.count).to eql(12)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.vegetarian).sum(:quantity)).to eql(12)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.gluten_free).sum(:quantity)).to eql(28)
      expect(restaurant_b.meals.where(dietary_restriction: DietaryRestriction.none).sum(:quantity)).to eql(80)
    end
  end
end

def create_example_stock(restaurant, stock_hashes)
  stock_hashes.each do |stock_hash|
    create(:stock, restaurant: restaurant, dietary_restriction: stock_hash[:dietary_restriction], quantity: stock_hash[:quantity])
  end
end

def create_example_members(team, member_summary_hashes)
  member_summary_hashes.each do |member_summary|
    dietary_restriction = member_summary[:dietary_restriction]
    (1..member_summary[:quantity]).each do
      create(:member, dietary_restriction: dietary_restriction, team: team)
    end
  end
end

