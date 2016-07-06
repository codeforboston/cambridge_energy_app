require 'rails_helper'

describe GraphController do 
  
  before(:each) do
    @user = create(:user, unit: @unit)
    sign_in @user
  end

  describe 'GET #index' do
    it 'is successful' do
      get(:index)
      expect(assigns(:user)).not_to be_nil

      # And make sure we're assigning the right person (current_user).
      expect(assigns(:user).id).to eq(@user.id)
    end
  end

end