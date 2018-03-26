require 'rails_helper'

RSpec.describe DietaryRestriction, type: :model do
  let(:dietary_restriction) { create(:dietary_restriction) }

  context '#valid?' do
    it 'handles no name' do
      dietary_restriction.name = nil

      expect(dietary_restriction.valid?).to be_falsey
      expect(dietary_restriction.errors.count).to eql(1)
      expect(dietary_restriction.errors.full_messages.first).to eql("Name can't be blank")

    end

    it 'handles blank name' do
      dietary_restriction.name = '   '

      expect(dietary_restriction.valid?).to be_falsey
      expect(dietary_restriction.errors.count).to eql(1)
      expect(dietary_restriction.errors.full_messages.first).to eql("Name can't be blank")
    end

    it 'handles max string size' do
      dietary_restriction.name = 'a'*50

      expect(dietary_restriction.valid?).to be_truthy
    end

    it 'handles name size too big error' do
      dietary_restriction.name = 'a'*51

      expect(dietary_restriction.valid?).to be_falsey
      expect(dietary_restriction.errors.count).to eql(1)
      expect(dietary_restriction.errors.full_messages.first).to eql('Name is too long (maximum is 50 characters)')
    end

    it 'should create valid dietary restriction' do
      dietary_restriction.name = 'dietary restriction'

      expect(dietary_restriction.persisted?).to be_truthy
    end
  end
end
