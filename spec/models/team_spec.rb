require 'rails_helper'

describe Team do

  it { should have_many :users }
  it { should have_many :receivers }
  
  it do
    should have_many(:invitations).
      dependent(:destroy).
      with_foreign_key('sender_id')
  end
end