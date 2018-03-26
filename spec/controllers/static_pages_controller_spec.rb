require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe '#home' do
    it 'returns http success' do
      get :home
      expect(response.status).to eql(200)
    end
  end
end
