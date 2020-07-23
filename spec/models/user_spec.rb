require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  describe '#author_of?' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
    
    context 'Valid' do
      it 'checks author_id for question' do
        expect(user.author_of?(question)).to eq(true)
      end
      it 'checks author_id for answer' do
        expect(user.author_of?(answer)).to eq(true)
      end
    end

    context 'Invalid' do
    let(:user1) { create(:user) }
      it 'checks author_id for question' do
        expect(user1.author_of?(question)).to eq(false)
      end
      it 'checks author_id for answer' do
        expect(user1.author_of?(answer)).to eq(false)
      end
    end
  end
end
