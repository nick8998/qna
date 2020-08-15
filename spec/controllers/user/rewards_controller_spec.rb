require 'rails_helper'

RSpec.describe User::RewardsController, type: :controller do
    let(:user) { create(:user) }
    let(:question1) { create(:question, author: user) }
    let(:question2) { create(:question, author: user) }
    let!(:reward1) { create(:reward, question: question1) }
    let!(:reward2) { create(:reward, question: question2) }
    let!(:got_reward1) { create(:got_reward, user: user, reward: reward1) } 
    let!(:got_reward2) { create(:got_reward, user: user, reward: reward2) } 

    describe 'GET #index' do 
      before { login(user) }
      before { get :index }
      
      it 'populates an array of all questions' do
        expect(assigns(:rewards)).to match_array([reward1, reward2])
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end
end
