require 'rails_helper'

describe Unit do

  it { should belong_to :user_building }
  it { should have_many :users }
  it { should have_many :bills }

  it { should have_valid(:number_occupants).when(0, 20) }
  it { should_not have_valid(:number_occupants).when(nil, "", "String", 21, -1) }

end
