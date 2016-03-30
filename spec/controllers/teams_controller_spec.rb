require 'rails_helper'

describe TeamsController do

  before(:each) {
    @team = create(:team)
  }

  describe 'GET #index ' do

    context 'when user is signed in' do
      it do
        user = create(:user)
        sign_in user
        get :index
        is_expected.to respond_with :ok
        is_expected.to render_template :index
      end
    end

    context 'when user is not signed in' do
      before { get :index }
      it { is_expected.to redirect_to(controller: 'devise/sessions', action: :new) }
    end

    it { expect(@team).to_not be nil }
  end
end
