require 'rails_helper'

describe TeamsController, :type => :controller do
  let(:team) { create(:team) }

  render_views

  context '#index' do
    it 'should get to index' do
      team # instantiate

      get :index

      expect(response.status).to eq(200)
      expect(assigns(:teams)).to eq([team])
    end
  end

  context '#show' do
    it 'should show team' do
      get :show, id: team.id

      expect(response.status).to eq(200)
      expect(assigns(:team)).to eq(team)
    end
  end

  context '#new' do
    it 'should create new team' do
      get :new

      expect(response.status).to eq(200)
      expect(assigns(:team)).to be_a_new(Team)
    end
  end

  context '#edit' do
    it 'should edit team' do
      get :edit, id: team.id

      expect(response.status).to eq(200)
      expect(assigns(:team)).to eq(team)
    end
  end

  context '#update' do
    it 'should update team' do
      put :update, id: team.id, team: {name: 'other-team-name'}

      expect(response.status).to eq(302) # redirect
      expect(team.reload.name).to eq('other-team-name')
      expect(flash[:notice]).to eq('Team was successfully updated.')
    end
  end

  context '#create' do
    it 'should create team' do
      post :create, team: {name: 'new-team'}

      expect(response.status).to eq(302) # redirect
      expect(team.persisted?).to be_truthy
      expect(flash[:notice]).to eq('Team was successfully created.')
    end
  end

end