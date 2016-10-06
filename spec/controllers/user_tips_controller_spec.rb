require 'rails_helper'

describe UserTipsController do
  let(:user) { create(:user) }
  let(:tip) { Tip.create }
  let(:user_tip_params) { {user_id: user, tip_id: tip, result: 'Liked', feedback: 'This tip was good'} }
  before(:each) { sign_in user }

  describe "POST #create" do
      it 'saves the new UserTip in the database' do
        expect { post :create, user_tip: user_tip_params }.to change{
          UserTip.count
        }.by(1)
        uploaded_user_tip = UserTip.last
        expect(uploaded_user_tip.feedback).to_not be_nil
        expect(uploaded_user_tip.user).to eq user
      end
  end
end
