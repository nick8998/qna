require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  describe 'DELETE #destroy' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, author: user, links_attributes: [ {name: "Google", url: "https://google.com", author: user}, {name: "Google", url: "https://google.com", author: user} ]) }
    let!(:answer) { create(:answer, question: question, author: user, links_attributes: [ {name: "Google", url: "https://google.com", author: user}, {name: "Google", url: "https://google.com", author: user} ]) }

    context 'Author' do
      before { login(user) }

      it 'deletes file from question' do
        expect{ delete :destroy, params: { id: 1 }, format: :js }.to change(question.links, :count).by(-1)
      end

      it 'deletes file from answer' do
        expect{ delete :destroy, params: { id: 3 }, format: :js }.to change(answer.links, :count).by(-1)
      end
    end

    context 'Not author' do
      let(:user1) { create(:user) }
      before { login(user1) }

      it 'deletes links from question' do
        expect{ delete :destroy, params: { id: 1 }, format: :js }.not_to change(question.links, :count)
      end

      it 'deletes links from answer' do
        expect{ delete :destroy, params: { id: 3 }, format: :js }.not_to change(answer.links, :count)
      end
    end
  end
end
