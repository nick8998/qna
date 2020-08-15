require 'rails_helper'

RSpec.describe VotesUser, type: :model do
  it { should belong_to :user }
  it { should belong_to :vote }
end
