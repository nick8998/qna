require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :votable }
  it { should have_many(:users).dependent(:destroy) }
end
