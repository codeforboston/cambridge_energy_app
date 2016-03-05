require 'rails_helper'

describe User do

  it { should belong_to :team }
  it { should belong_to :unit }
  it { should have_many :bills }

end
