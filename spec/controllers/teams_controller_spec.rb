require 'rails_helper'

describe TeamsController do
  before(:each) { @team = create(:team) }

  describe 'GET #index' do
    context 'when user is signed in' do
      it 'is successful' do
        user = create(:user)
        sign_in user
        get :index

        expect(response).to be_success
        expect(response).to render_template :index
      end
    end

    context 'when user is not signed in' do
      it 'is redirects user to login page' do
        get :index

        expect(response).to redirect_to(
          controller: 'devise/sessions',
          action: :new
        )
      end
    end
  end

  describe 'GET #new' do
    context 'when user is signed in' do
      it 'is successful' do
        user = create(:user)
        sign_in user
        get :new

        expect(response).to be_success
        expect(response).to render_template :new
      end
    end

    context 'when user is not signed in' do
      it 'it redirects to user login page' do
        get :index

        expect(response).to redirect_to(
          controller: 'devise/sessions',
          action: :new
        )
      end
    end
  end

  describe 'POST #create' do
    context 'when user is signed in' do
      it 'is successful' do
        user = create(:user)
        sign_in user
        team = attributes_for(:team)

        expect{ post(:create, team: team) }.to change{ Team.count }.by(1)
      end
    end

    context 'when user is not signed in' do
      it 'is not successful' do
        team = attributes_for(:team)

        expect{ post(:create, team: team) }.to change{ Team.count }.by(0)
      end
    end
  end

  describe 'PATCH #update' do
    context 'when user is signed in' do
      it 'is successful' do
        user = create(:user)
        sign_in user
        updated_team = attributes_for(:team, name: 'Team NotSoAwesome')

        expect{ patch(:update, id: @team.id, team: updated_team) }
          .to change{ Team.count }.by(0)
        expect(response).to redirect_to team_path(@team)
      end
    end

    context 'when user is not signed in' do
      it 'is not successful' do
        updated_team = attributes_for(:team, name: 'Team NotSoAwesome')

        expect{ patch(:update, id: @team.id, team: updated_team) }
          .to change{ Team.count }.by(0)
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe 'GET #leave' do
    let(:team)  { create(:team) }
    let(:user1) { create(:user, team: team) }
    let(:expectation) { expect{ get(:leave, id: team.id) } }

    before(:each) { sign_in user1 }

    context 'team has more than one member' do
      it 'does not destroy team' do
        create(:user, team: team)

        expectation.to change{ team.users.count }.by(-1)
        expectation.to_not change{ Team.count }
        expect(response).to redirect_to users_me_path
      end
    end

    context 'team has a single member' do
      it 'destroys team when last member leaves' do
        expectation.to change{ Team.count }.by(-1)
        expect(response).to redirect_to users_me_path
      end
    end
  end

  describe 'GET #leaderboard' do
    it 'is successful' do
      sign_in create(:user)
      get(:leaderboard)

      expect(response).to render_template :leaderboard
    end

    it 'is not successful due to user not logged in' do
      get(:leaderboard)

      expect(response).to redirect_to new_user_session_path
    end
  end
end
