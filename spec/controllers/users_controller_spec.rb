require 'rails_helper'

describe UsersController do
  let(:user) { create(:user) }

  #write feature test for signed-in/signed-out
  describe 'GET #show' do
    it 'renders #show' do
      sign_in user
      get :show
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    it 'renders #edit' do
      sign_in user
      get :show
      expect(response).to be_success
    end
  end


  describe 'PATCH #update' do
    context 'when information is valid' do
      it 'successfully updates user' do
        valid_user_attrs = { phone: '1234567890' }
        sign_in user

        patch(:update, user: valid_user_attrs)

        expect(response).to render_template("show")
      end
    end

    context 'when information is invalid' do
      it 'renders #edit' do
        invalid_user_attrs = { phone: 'not a string of numbers' }
        sign_in user

        patch(:update, user: invalid_user_attrs)

        expect(response).to render_template("edit")
      end
    end
  end
end
