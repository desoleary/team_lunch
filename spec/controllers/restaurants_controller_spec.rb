require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe RestaurantsController, type: :controller do

  let(:restaurant) { create(:restaurant) }

  describe '#index' do
    it 'assigns all restaurants as @restaurants' do
      get :index

      expect(response.status).to eql(200)
      expect(assigns(:restaurants)).to eq([restaurant])
    end
  end

  describe '#show' do
    it 'assigns the requested restaurant as @restaurant' do
      get :show, {:id => restaurant.id}

      expect(response.status).to eql(200)
      expect(assigns(:restaurant)).to eq(restaurant)
    end
  end

  describe '#new' do
    it 'assigns a new restaurant as @restaurant' do
      get :new

      expect(response.status).to eql(200)
      expect(assigns(:restaurant)).to be_a_new(Restaurant)
    end
  end

  describe '#edit' do
    it 'assigns the requested restaurant as @restaurant' do
      get :edit, {:id => restaurant.id}

      expect(response.status).to eql(200)
      expect(assigns(:restaurant)).to eq(restaurant)
    end
  end

  describe '#create' do
    context 'with valid params' do
      it 'creates a new Restaurant' do
        post :create, {:restaurant => build(:restaurant).as_json}

        expect(response.status).to eql(302)
        expect(assigns(:restaurant)).to be_a(Restaurant)
        expect(Restaurant.count).to eql(1)
        expect(response).to redirect_to(Restaurant.last)
      end
    end

    context 'with invalid params' do
      it 'assigns a newly created but unsaved restaurant as @restaurant' do
        new_restaurant = build(:restaurant)
        new_restaurant.name = ''

        post :create, {:restaurant => new_restaurant.as_json}

        expect(response.status).to eql(200)
        expect(assigns(:restaurant)).to be_a_new(Restaurant)
      end

      it "re-renders the 'new' template" do
        new_restaurant = build(:restaurant)
        new_restaurant.name = ''

        post :create, {:restaurant => new_restaurant.as_json}

        expect(response.status).to eql(200)
        expect(response).to render_template('new')
      end
    end
  end

  describe '#update' do
    context 'with valid params' do
      it 'updates the requested restaurant' do
        restaurant.name = 'updated-restaurant'
        put :update, {:id => restaurant.id, :restaurant => restaurant.as_json}

        expect(response.status).to eql(302)
        expect(response).to redirect_to(restaurant)
        expect(assigns(:restaurant)).to eq(restaurant)
        expect(restaurant.reload.name).to eql('updated-restaurant')

      end
    end

    context 'with invalid params' do
      it 'assigns the restaurant as @restaurant' do
        restaurant.name = '  '
        put :update, {:id => restaurant.id, :restaurant => restaurant.as_json}
        expect(assigns(:restaurant)).to eq(restaurant)
      end

      it "re-renders the 'edit' template" do
        restaurant.name = '  '
        put :update, {:id => restaurant.id, :restaurant => restaurant.as_json}
        expect(response).to render_template('edit')
      end
    end
  end

  describe '#destroy' do
    it 'destroys the requested restaurant' do
      delete :destroy, {:id => restaurant.id}

      expect(Restaurant.where(id: restaurant.id).first).to be_nil
    end

    it 'redirects to the restaurants list' do
      delete :destroy, {:id => restaurant.id}

      expect(response.status).to eql(302)
      expect(response).to redirect_to(restaurants_url)
    end
  end

end