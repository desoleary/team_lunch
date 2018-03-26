require 'rails_helper'

RSpec.describe Team, type: :model do
  let(:team) { create(:team) }

  context '#valid?' do
    it 'handles no name' do
      team.name = nil

      expect(team.valid?).to be_falsey
      expect(team.errors.count).to eql(1)
      expect(team.errors.full_messages.first).to eql("Name can't be blank")

    end

    it 'handles blank name' do
      team.name = '   '

      expect(team.valid?).to be_falsey
      expect(team.errors.count).to eql(1)
      expect(team.errors.full_messages.first).to eql("Name can't be blank")
    end

    it 'handles max string size' do
      team.name = 'a'*255

      expect(team.valid?).to be_truthy
    end

    it 'handles name size too big error' do
      team.name = 'a'*256

      expect(team.valid?).to be_falsey
      expect(team.errors.count).to eql(1)
      expect(team.errors.full_messages.first).to eql('Name is too long (maximum is 255 characters)')
    end
  end

  context '#init' do
    it 'should create valid team' do
      team.name = 'team name'

      expect(team.persisted?).to be_truthy
    end
  end

  context '#members' do
    it 'exposes members associated with team' do
      member1 = create(:member, team: team)
      member2 = create(:member, team: team)

      expect(team.members).to match_array([member1, member2])
    end
  end
end
