require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  let(:restaurant) { create(:restaurant) }

  context '#name valid?' do
    it 'handles no name' do
      restaurant.name = nil

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(1)
      expect(restaurant.errors.full_messages.first).to eql("Name can't be blank")
    end

    it 'handles blank name' do
      restaurant.name = '  '

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(1)
      expect(restaurant.errors.full_messages.first).to eql("Name can't be blank")
    end

    it 'handles max name size' do
      restaurant.name = 'a'*255

      expect(restaurant.valid?).to be_truthy
    end

    it 'handles name size too big' do
      restaurant.name = 'a'*256

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(1)
      expect(restaurant.errors.full_messages.first).to eql('Name is too long (maximum is 255 characters)')
    end

    it 'should create valid restaurant' do
      restaurant.name = 'name'

      expect(restaurant.valid?).to be_truthy
    end
  end

  context '#rating valid?' do
    it 'handles valid min rating' do
      restaurant.rating = 1

      expect(restaurant.valid?).to be_truthy
    end

    it 'handles valid max rating' do
      restaurant.rating = 5

      expect(restaurant.valid?).to be_truthy
    end

    it 'handles no rating' do
      restaurant.rating = nil

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(2)
      expect(restaurant.errors.full_messages.first).to eql("Rating can't be blank")
      expect(restaurant.errors.full_messages.second).to eql('Rating is not a number')

    end

    it 'handles blank rating' do
      restaurant.rating = '   '

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(2)
      expect(restaurant.errors.full_messages.first).to eql("Rating can't be blank")
      expect(restaurant.errors.full_messages.second).to eql('Rating is not a number')
    end

    it 'handles rating too small' do
      restaurant.rating = 0

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(1)
      expect(restaurant.errors.full_messages.first).to eql('Rating must be greater than or equal to 1')
    end

    it 'handles rating too big' do
      restaurant.rating = 6

      expect(restaurant.valid?).to be_falsey
      expect(restaurant.errors.count).to eql(1)
      expect(restaurant.errors.full_messages.first).to eql('Rating must be less than or equal to 5')
    end
  end

end
