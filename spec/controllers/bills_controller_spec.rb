require 'rails_helper'

describe BillsController do

  describe "GET #index" do
    let!(:bill) { FactoryGirl.create(:bill) }
    before { get :index }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :index }
    it { expect(bill).to_not be nil }
  end

  describe "GET #new" do
    before { get :new }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :new }
  end

  describe "POST #create" do
    let!(:user) { FactoryGirl.create(:user) }

    it "should create bill" do
      sign_in user
      assert_difference('Bill.count') do
        post :create, bill: FactoryGirl.attributes_for(:bill).merge(user_id: user.id)
      end
    end
  end

  describe 'GET #edit' do
    let!(:bill) { FactoryGirl.create(:bill) }
    before { get :edit, id: bill }

    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :edit }
  end

  describe 'POST #update' do
    let!(:bill) {FactoryGirl.create(:bill) }
    before do
      patch(:update, id: bill,
        bill: {
          amount: bill.amount,
          bill_received: bill.bill_received,
          user_id: bill.user_id
        }
      )
    end

    it { is_expected.to redirect_to bill_path(bill) }
  end

  describe 'DELETE #destroy' do
    let!(:bill) {FactoryGirl.create(:bill) }
    before do
      assert_difference('Bill.count', -1) { delete :destroy, id: bill }
    end

    it { is_expected.to redirect_to bills_path }
  end

end
