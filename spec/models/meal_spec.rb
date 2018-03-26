require 'rails_helper'

RSpec.describe Meal, type: :model do
  let(:meal) { create(:meal) }

  context '#uniqueness' do
    it 'should not allow multiple meal items with the same dietary restrictions and restaurant' do
      another_meal = meal.dup

      expect(another_meal.valid?).to be_falsey
      expect(another_meal.errors.count).to eql(1)
      expect(another_meal.errors.full_messages.first).to eql('Dietary restriction has already been taken')
    end
  end

  context '#quantity valid?' do
    it 'handles valid quantity' do
      meal.quantity = 500

      expect(meal.valid?).to be_truthy
    end

    it 'handles no quantity' do
      meal.quantity = nil

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(2)
      expect(meal.errors.full_messages.first).to eql("Quantity can't be blank")
      expect(meal.errors.full_messages.second).to eql('Quantity is not a number')

    end

    it 'handles blank quantity' do
      meal.quantity = '   '

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(2)
      expect(meal.errors.full_messages.first).to eql("Quantity can't be blank")
      expect(meal.errors.full_messages.second).to eql('Quantity is not a number')
    end

    it 'handles quantity too small' do
      meal.quantity = 0

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(1)
      expect(meal.errors.full_messages.first).to eql('Quantity must be greater than or equal to 1')
    end
  end

  context '#dietary restriction valid?' do
    it 'handles valid dietary restriction' do
      meal.dietary_restriction = DietaryRestriction.fish_free

      expect(meal.valid?).to be_truthy
    end

    it 'handles no dietary restriction' do
      meal.dietary_restriction = nil

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(1)
      expect(meal.errors.full_messages.first).to eql("Dietary restriction can't be blank")
    end

    it 'should create valid member' do
      meal.dietary_restriction = DietaryRestriction.create(name: "dietary restriction")

      expect(meal.valid?).to be_truthy
    end
  end

  context '#order valid?' do
    it 'handles no order' do
      meal.order = nil

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(1)
      expect(meal.errors.full_messages.first).to eql("Order can't be blank")
    end

    it 'should create valid meal' do
      meal.order = Order.create(order_date: Date.current)

      expect(meal.valid?).to be_truthy
    end
  end

  context '#restaurant valid?' do
    it 'handles no restaurant' do
      meal.restaurant = nil

      expect(meal.valid?).to be_falsey
      expect(meal.errors.count).to eql(1)
      expect(meal.errors.full_messages.first).to eql("Restaurant can't be blank")
    end

    it 'should create valid meal' do
      meal.restaurant = Restaurant.create(name: "restaurant name",
                                    rating: 3
      )

      expect(meal.valid?).to be_truthy
    end
  end
end
