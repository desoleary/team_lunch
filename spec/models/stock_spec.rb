require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:stock) { create(:stock) }

  context '#uniqueness' do
    it 'should not allow multiple stock items with the same dietary restrictions and restaurant' do
      another_stock = stock.dup

      expect(another_stock.valid?).to be_falsey
      expect(another_stock.errors.count).to eql(1)
      expect(another_stock.errors.full_messages.first).to eql('Dietary restriction has already been taken')
    end
  end

  context '#quantity valid?' do
    it 'handles valid quantity' do
      stock.quantity = 500

      expect(stock.valid?).to be_truthy
    end

    it 'handles no quantity' do
      stock.quantity = nil

      expect(stock.valid?).to be_falsey
      expect(stock.errors.count).to eql(2)
      expect(stock.errors.full_messages.first).to eql("Quantity can't be blank")
      expect(stock.errors.full_messages.second).to eql('Quantity is not a number')

    end

    it 'handles blank quantity' do
      stock.quantity = '   '

      expect(stock.valid?).to be_falsey
      expect(stock.errors.count).to eql(2)
      expect(stock.errors.full_messages.first).to eql("Quantity can't be blank")
      expect(stock.errors.full_messages.second).to eql('Quantity is not a number')
    end

    it 'handles quantity too small' do
      stock.quantity = 0

      expect(stock.valid?).to be_falsey
      expect(stock.errors.count).to eql(1)
      expect(stock.errors.full_messages.first).to eql('Quantity must be greater than or equal to 1')
    end
  end

  context '#dietary restriction valid?' do
    it 'handles valid dietary restriction' do
      stock.dietary_restriction = DietaryRestriction.fish_free

      expect(stock.valid?).to be_truthy
    end

    it 'handles no dietary restriction' do
      stock.dietary_restriction = nil

      expect(stock.valid?).to be_falsey
      expect(stock.errors.count).to eql(1)
      expect(stock.errors.full_messages.first).to eql("Dietary restriction can't be blank")
    end

    it 'should create valid member' do
      stock.dietary_restriction = DietaryRestriction.create(name: "dietary restriction")

      expect(stock.valid?).to be_truthy
    end
  end
end
