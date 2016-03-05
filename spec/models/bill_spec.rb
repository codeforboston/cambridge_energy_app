require 'rails_helper'

describe Bill do

  it { should belong_to :user }
  it { should belong_to :unit }

end
