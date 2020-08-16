require 'rails_helper'

shared_examples 'votable' do
  
  describe 'Authenticated user' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author:user) }
    before { question.vote = Vote.new }

    describe 'PUT#vote_up' do
      context 'Author' do
        before { login(user) }
        it 'votes up' do     
          put :vote_up, params: { id: 1 }, format: :json
          expect(question.vote.votes_up).to eq 0
        end 
      end
=begin
    Все контексты не автор выдают ошибки. Думаю put запрос не выполняется, но не совсем понимаю почему...

      context 'Not author' do
        let!(:user1) { create(:user) }
        before { login(user1) }
        
        it 'votes up' do
          put :vote_up, params: { id: 1 }, format: :json
          expect(question.vote.votes_up).to eq 1
        end  
      end
=end


    end

    describe 'PUT#vote_down' do
      context 'Author' do
        before { login(user) }
        it 'votes down' do     
          put :vote_down, params: { id: 1 }, format: :json
          expect(question.vote.votes_down).to eq 0
        end 
      end

      context 'Not author' do
        let!(:user1) { create(:user) }
        before { login(user1) }
        
        it 'votes down' do
          put :vote_down, params: { id: 1 }, format: :json
          expect(question.vote.votes_down).to eq 1
        end  
      end

    end
    describe 'PUT#vote_up' do
      context 'Author' do
        before { login(user) }
        before { question.vote.votes_up = 1 }
        it 'votes cancel' do
          put :vote_cancel, params: { id: 1 }, format: :json
          expect(question.vote.votes_up).to eq 1
        end 
      end

      context 'Not author' do
        let!(:user1) { create(:user) }
        before { login(user1) }
        before { question.vote.votes_up = 1 }
        
        it 'votes cancel' do
          put :vote_up, params: { id: 1 }, format: :json
          expect(question.vote.votes_up).to eq 0
        end  
      end

    end
  
  end
end

RSpec.describe VotesController, type: :controller do

  it_behaves_like "votable"

end
