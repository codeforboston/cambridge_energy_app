require 'rails_helper'

describe Unit do

  it { should belong_to :user_building }
  it { should have_many :users }
  it { should have_many :bills }

end
