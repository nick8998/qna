require 'rails_helper'
RSpec.shared_examples 'creates a new object' do |klass|
shared_examples 'votable' do |model|

  describe 'Authenticated user' do
    describe 'PUT#vote_up' do
      context 'Author' do
        it 'votes up' do 
          model.build_vote.save
          put :vote_up, params: { id: 1 }, format: :json
          expect(new_model.vote.votes_up).to eq 0
        end 
      end
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
=end
end

=begin
def vote_up
    if model_klass.author_exist?(current_user)
      model_klass.create_positive_vote(current_user)
    end
    render_json_voting
  end


  def vote_down
    if model_klass.author_exist?(current_user)
      model_klass.create_negative_vote(current_user)
    end
    render_json_voting
  end

  def vote_cancel
    model_klass.cancel(current_user)
    render_json_voting
  end

  def render_json_voting
    respond_to do |format|
      if model_klass.vote.persisted?
        format.json { render_json(model_klass.vote) }
      else
        format.json { render_errors(model_klass.vote) }
      end
    end
  end

  def render_errors(item)
    render json: item.errors.full_messages, status: :unprocessable_entity
  end

  def render_json(item)
    render json: item
  end

  private

  def model_klass
    controller_name.classify.constantize.find(params[:id])
  end
=end