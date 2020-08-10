require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should belong_to :question }

  it { should have_many(:got_rewards).dependent(:destroy) }
  it { should have_many(:users).through(:got_rewards).dependent(:destroy) }

  it { should validate_presence_of :title }
  it { should validate_presence_of :picture }
end
