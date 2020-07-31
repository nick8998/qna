require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should belong_to(:author).class_name('User').optional }
  it { should have_many(:answers).dependent(:destroy)}

  describe '#best_answers?' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question, best: true) }
    
    context 'Valid' do
      it 'checks count of best answers' do
        expect(question.best_answers?).to be true
      end
    end

    context 'Invalid' do
    let!(:question1) { create(:question, author: user) }
    let!(:answer) { create(:answer, author: user, question: question) }
      it 'checks count of best answers' do
        expect(question1.best_answers?).to be false
      end
    end
  end
end
