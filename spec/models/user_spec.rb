require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should have_many(:rewards).dependent(:destroy) }
  it { should have_many(:votes).dependent(:destroy) }
  it { should have_many(:votes).through(:votes_users).dependent(:destroy) }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    
    context 'Valid' do
      it 'checks author_id' do
        expect(user).to be_author_of(question)
      end
    end

    context 'Invalid' do
    let(:user1) { create(:user) }
      it 'checks author_id' do
        expect(user1).not_to be_author_of(question)
      end
    end
  end
end
