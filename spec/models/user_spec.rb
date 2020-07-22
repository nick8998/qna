require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }

  context "self.author_of?" do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
    it 'checks author_id for question' do
      expect(user.author_of?(question)).to eq(true)
    end
    it 'checks author_id for answer' do
      expect(user.author_of?(answer)).to eq(true)
    end
  end
end
