require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should belong_to(:author).class_name('User').optional }
  it { should belong_to :question }
  it_behaves_like "Votable"
  it_behaves_like "Linkable"
  it_behaves_like "Many Files" do
    let(:files) { Answer.new.files }
  end

  describe '#choose_best' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user) }
    let!(:answer1) { create(:answer, question: question, best: false) }
    
    
    context 'Valid' do
      it 'checks best with one answer' do
        answer1.choose_best
        expect(answer1).to be_best
      end

      let!(:answer2) { create(:answer, question: question, best: false) }
      it 'checks best with some answers' do
        answer2.choose_best
        expect(answer2).to be_best
        expect(answer1).not_to be_best
      end
    end

    context 'Invalid' do
      let!(:answer1) { create(:answer, question: question, best: true) }
      it 'checks best' do
        answer1.choose_best
        expect(answer1).to be_best
      end
    end
  end

end


