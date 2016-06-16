require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  #write feature test for signed-in/signed-out
  describe 'GET #show' do
    it 'renders #show' do
      get :show
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'renders #edit' do
      get :show
      expect(response).to be_success
    end
  end


  describe 'PATCH #update' do
    context 'when information is valid' do
      it 'successfully updates user' do
        valid_user = attributes_for(:user, first_name: 'The', last_name: 'Rock',
          phone: '1234567890', image: 'http://media3.s-nbcnews.com/i/newscms/2015_37/764896/the-rock-saves-puppy-today-tease-1-150908_54fb4b0bfa08dee373c956cefb9b9c49.jpg')

        patch(:update, user: valid_user)
        expect(response).to render_template("show")
      end
    end

    context 'when information is invalid' do
      it 'renders #edit' do
        invalid_user = attributes_for(:user, phone: 'not a string of numbers')

        patch(:update, user: invalid_user)
          expect(response).to render_template("edit")
      end
    end
  end
end
