require 'rails_helper'

RSpec.describe Reward, type: :model do
  it { should belong_to :question }

  it { should have_many(:got_rewards).dependent(:destroy) }
  it { should have_many(:users).through(:got_rewards).dependent(:destroy) }

  it { should validate_presence_of :title }

  it 'have one attached image' do
    expect(Reward.new.image).to be_an_instance_of(ActiveStorage::Attached::One)
  end
end
