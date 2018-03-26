require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) { create(:member) }

  context '#first name valid?' do
    it 'handles no first name' do
      member.first_name = nil

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("First name can't be blank")
    end

    it 'handles blank first name' do
      member.first_name = '  '

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("First name can't be blank")
    end

    it 'handles max first name size' do
      member.first_name = 'a'*255

      expect(member.valid?).to be_truthy
    end

    it 'handles first name size too big' do
      member.first_name = 'a'*256

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql('First name is too long (maximum is 255 characters)')
    end

    it 'should create valid member' do
      member.first_name = 'first name'

      expect(member.valid?).to be_truthy
    end
  end

  context '#last name valid?' do
    it 'handles no last name' do
      member.last_name = nil

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("Last name can't be blank")
    end

    it 'handles blank last name' do
      member.last_name = '  '

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("Last name can't be blank")
    end

    it 'handles max last name size' do
      member.last_name = 'a'*255

      expect(member.valid?).to be_truthy
    end

    it 'handles last name size too big' do
      member.last_name = 'a'*256

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql('Last name is too long (maximum is 255 characters)')
    end

    it 'should create valid member' do
      member.last_name = 'last name'

      expect(member.valid?).to be_truthy
    end
  end

  context '#team valid?' do
    it 'handles no team' do
      member.team = nil

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("Team can't be blank")
    end

    it 'should create valid member' do
      member.team = Team.create(name: "team name")

      expect(member.valid?).to be_truthy
    end
  end

  context '#dietary restriction valid?' do
    it 'handles no dietary restriction' do
      member.dietary_restriction = nil

      expect(member.valid?).to be_falsey
      expect(member.errors.count).to eql(1)
      expect(member.errors.full_messages.first).to eql("Dietary restriction can't be blank")
    end

    it 'should create valid member' do
      member.dietary_restriction = DietaryRestriction.create(name: "dietary restriction")

      expect(member.valid?).to be_truthy
    end
  end
end
