require 'rails_helper'

describe BillsController do

  let(:bill) { create(:bill) }
  let(:user) { User.find(bill.user_id) }
  before(:each) { sign_in user }

  describe 'GET #index' do
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

    it "should create bill" do
      user = create(:user)
      sign_in user
      bill = attributes_for(:bill).merge(user_id: user.id, units: {number_occupants: 4})

      expect{ post(:create, bill: bill) }.to change{ Bill.count }.by(1)
    end
  end

  describe "GET #edit" do
    before { get :edit, id: bill }
    
    it { is_expected.to respond_with :ok }
    it { is_expected.to render_template :edit }
  end


  describe "GET #comparison" do
    before { get :comparison }

    it { is_expected.to render_template :comparison }
  end

  describe "PATCH #update" do

    it "redirects to the bill show page" do
      bill_attributes = { amount: 42.42, bill_received: '01-01-16' }
      patch(:update, id: bill.id, bill: bill_attributes)

      expect(response).to redirect_to bill_path(bill)
    end
  end

  describe "DELETE #destroy" do
    it "destroys a bill" do
      expect{ delete(:destroy, id: bill.id) }.to change{ Bill.count }.by(-1)

      is_expected.to redirect_to bills_path
    end
  end

end
