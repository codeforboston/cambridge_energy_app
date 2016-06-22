require 'rails_helper'

describe Tip do

let(:tip) { create :tip, text: "Do stuff" }
let(:user) { create :user, tipnum: 0 }
  context "Validations" do
    it { should validate_presence_of :text }
  end 

  describe '.liked_votes' do
    let(:tip_liked) { create :tip_with_likes }
    it 'should return the number of liked votes' do
      expect(tip_liked.liked_votes).to eq 1
    end
  end

  describe '.disliked_votes' do
    let(:tip_disliked) { create :tip_with_dislikes }
    it 'should return the number of disliked votes' do
      expect(tip_disliked.disliked_votes).to eq 1
    end
  end

  describe '.not_disliked' do 
    let(:tip_not_liked) { create :tip }
    it 'should return the number of tips that were not disliked' do
      user_tip = UserTip.create(result: "Disliked", tip: tip_not_liked, user: user) 
      number_of_not_disliked_tips = Tip.all.length - 1
      expect(Tip.not_disliked(user).length).to eq number_of_not_disliked_tips
    end
  end

  describe '.get_tip' do
    first_tip = Tip.all.first 
    it 'should return the current tip for the user' do
      current_tip = Tip.get_tip(user)
      expect(current_tip.id).to eq first_tip.id
    end
  end

  describe '.next_tip' do
    it 'should change the tipnum for the user' do
      Tip.next_tip(user)
      expect(user.tipnum).not_to eq 0
    end
  end

  describe '.vote' do
    it 'should be able to add a liked vote' do
      number_of_liked_user_tips = UserTip.select{ |utip| utip.result == "Liked" }.length
      Tip.vote(user,"Liked")
      expect(UserTip.select{ |utip| utip.result == "Liked" }.length).to eq number_of_liked_user_tips + 1
    end

    it 'should be able to add a disliked vote' do
      number_of_disliked_user_tips = UserTip.select{ |utip| utip.result == "Disliked" }.length
      Tip.vote(user,"Disliked")
      expect(UserTip.select{ |utip| utip.result == "Disliked" }.length).to eq number_of_disliked_user_tips + 1
    end
  end
end
