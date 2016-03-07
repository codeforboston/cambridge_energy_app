require "rails_helper"

RSpec.describe InvitationsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/invitations").to route_to("invitations#index")
    end

    it "routes to #new" do
      expect(:get => "/invitations/new").to route_to("invitations#new")
    end

    it "routes to #show" do
      expect(:get => "/invitations/1").to route_to("invitations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/invitations/1/edit").to route_to("invitations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/invitations").to route_to("invitations#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/invitations/1").to route_to("invitations#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/invitations/1").to route_to("invitations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/invitations/1").to route_to("invitations#destroy", :id => "1")
    end

  end
end
