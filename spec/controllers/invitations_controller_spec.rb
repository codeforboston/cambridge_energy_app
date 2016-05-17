require 'rails_helper'

describe InvitationsController do
  
  let(:invitation)  { create(:invitation) }
  before(:each) { sign_in invitation.receiver }

  describe 'GET #index' do
    it 'is successful' do
      get :index

      expect(response).to be_success
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    it 'is successful' do
      get :show, id: invitation.id

      expect(response).to be_success
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'is successful' do
      get :new

      expect(response).to be_success
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    it 'is successful' do
      get :edit, id: invitation.id

      expect(response).to be_success
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    it 'creates a new invitation' do
      team = create(:team)
      invitation = attributes_for(:invitation).merge(sender_id: team.id)

      expect{ post(:create, invitation: invitation) }
        .to change{ Invitation.count }.by(1)
      expect(response).to redirect_to team
    end
  end

  describe 'PATCH #update' do
    it 'is successful' do
      new_message = 'We would really love for you to join our team!'
      invitation_update = lambda do
        patch(:update, id: invitation.id, invitation: { mssg: new_message })
      end

      expect(&invitation_update).to change{ Invitation.count }.by(0)
      expect(response).to redirect_to invitation
    end
  end

  describe 'DELETE #destroy' do
    context 'reciever declines invitation' do
      it 'is successful' do
        expect{ delete(:destroy, id: invitation.id) }
          .to change{ Invitation.count }.by(-1)
        expect(response).to redirect_to users_me_path
      end
    end

    context 'inviter cancels invitation' do
      it 'is successful' do
        sign_out invitation.receiver
        sign_in invitation.inviter
        expect{ delete(:destroy, id: invitation.id) }
          .to change{ Invitation.count }.by(-1)
        expect(response).to redirect_to invitation.sender
      end
    end
  end

  describe 'GET #join' do
    context 'reciever is already on a team' do
      it 'does not add current user to a new team' do
        user = create(:user, team: create(:team))
        invitation = create(:invitation, receiver: user)

        sign_out invitation.receiver
        sign_in user
        get(:join, id: invitation.id)

        expect(response).to redirect_to users_me_path
      end

      context 'reciever is not yet on a team' do
        it 'adds user to invitation attached to team' do
          sign_in invitation.receiver
          get(:join, id: invitation.id)

          expect(response).to redirect_to invitation.sender
        end
      end
    end
  end
end
