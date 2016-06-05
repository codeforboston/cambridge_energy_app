require 'rails_helper'

describe Team do

  context "Validations" do
    it { should validate_presence_of :name }
  end

  context "Associations" do
    it { should have_many :users }
  end
end