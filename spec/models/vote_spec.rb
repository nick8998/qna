require 'rails_helper'

RSpec.describe Vote, type: :model do
  it { should belong_to :question }
  it { should have_many(:users).dependent(:destroy) }
  it { should have_many(:users).through(:votes_users).dependent(:destroy) }
end
