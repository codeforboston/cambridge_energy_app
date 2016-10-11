require 'rails_helper'

describe UserTipsController do
  let(:user) { create(:user) }
  let(:tip) { Tip.create }
  let(:result) { 'Liked' }
  let(:feedback) { 'This tip was good' }
  let(:user_tip_params) { {user_id: user, tip_id: tip, result: result, feedback: feedback} }
  before(:each) { sign_in user }

  describe "POST #create" do
    it 'saves the new UserTip in the database' do
      expect { post :create, user_tip: user_tip_params }.to change{ UserTip.count }.by(1)

      uploaded_user_tip = UserTip.last

      expect(uploaded_user_tip.feedback).to eq(feedback)
      expect(uploaded_user_tip.tip).to eq(tip)
      expect(uploaded_user_tip.result).to eq(result)
      expect(uploaded_user_tip.user).to eq(user)
    end

    it 'does not save the new UserTip when the parameters are invalid' do
      bad_params = {user_id: user, something_else: 'bad data', tip_id: tip, result: 'different result', malice: 'mean users'}

      post :create, user_tip: bad_params

      uploaded_user_tip = UserTip.last

      expect{ uploaded_user_tip.malice }.to raise_error(NoMethodError)
      expect{ uploaded_user_tip.something_else }.to raise_error(NoMethodError)
      expect(uploaded_user_tip.result).to eq('different result')
      expect(uploaded_user_tip.user).to eq(user)
      expect(uploaded_user_tip.tip).to eq(tip)
    end
  end
end
