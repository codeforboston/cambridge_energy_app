require 'rails_helper'

describe BillsController do

  before(:each) { @bill = create(:bill) }

  describe 'GET #index' do
    before { get :index }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
    it { expect(@bill).to_not be nil }
  end

  describe "GET #new" do
    before { get :new }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :new }
  end

  describe "POST #create" do
    let(:user) { create(:user) }

    it "should create bill" do
      sign_in user
      bill = FactoryGirl.attributes_for(:bill).merge(user_id: user.id, units: {number_occupants: 4})

      assert_difference('Bill.count') { post :create, bill: bill }
    end
  end

  describe "GET #edit" do
    before { get :edit, id: @bill }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :edit }
  end

  describe "POST #update" do
    before do
      patch(:update, id: @bill.id,
        bill: {
          amount: 42.42,
          bill_received: '01-01-16'
        }
      )
    end

    it { is_expected.to redirect_to bill_path(@bill) }
  end

  describe "DELETE #destroy" do
    before do
      assert_difference('Bill.count', -1) { delete :destroy, id: @bill }
    end

    it { is_expected.to redirect_to bills_path }
  end

end
