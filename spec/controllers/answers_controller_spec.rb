require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'Authenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question, author: user) }

    describe 'GET #edit' do
      before { login(user) }
      before { get :edit, params: { id: answer.id } }

      it 'assigns the requested answer to @answer' do
        expect(assigns(:answer)).to eq answer
      end

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      before { login(user) }

      context 'with valid attributes' do
        it 'save a new answer in the database' do
          question = create(:question)
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id, author_id: user.id } }.to change(question.answers, :count).by(1)
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id, author_id: user.id } }.to change(user.authored_answers, :count).by(1)
        end

        it 'redirects to question' do
          post :create, params: { answer: attributes_for(:answer), question_id: question.id, author_id: user.id }

          expect(response).to redirect_to question_path(question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }}.to_not change(Answer, :count)
        end

        it 'redirects to question' do
          post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }

          expect(response).to redirect_to question_path(question)
        end
      end
    end

    describe 'PACH #update' do
      before { login(user) }
      context 'with valid attributes' do
        it 'assigns the requested answer to @answer' do
          patch :update, params: { id: answer,  answer: attributes_for(:answer) }
          expect(assigns(:answer)).to eq answer
        end

        it 'changes answer attributes' do
          patch :update, params: { id: answer,  answer: { body: 'new body' } } 
          answer.reload

          expect(answer.body).to eq 'new body'
        end

        it 'redirects to update answers' do
          patch :update, params: { id: answer,  answer: attributes_for(:answer)  }

          expect(response).to redirect_to answer.question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: answer,  answer: attributes_for(:answer, :invalid)  } }

        it 'does not change answer' do
          answer.reload

          expect(answer.body).to eq 'MyText'
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      before { login(user) }
      let!(:answer) { create(:answer, question_id: question.id) }

      it 'deletes the answer' do
        expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(0)
      end

      it 'redirect to question show view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to question_path(question)
      end
    end
  end

  describe 'Unauthenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author: user) }
    let(:answer) { create(:answer, question: question, author: user) }

    describe 'GET #edit' do
      before { get :edit, params: { id: answer, question_id: question,  author_id: user.id }  }
      it 'does not assigns the requested answer to @answer' do
        expect(assigns(:answer)).not_to eq answer
      end

      it "does not render edit view" do
        expect(response).not_to render_template :edit
      end
    end

    describe 'POST #create' do
      it 'does not save a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }}.to_not change(Answer, :count)
      end
    end

    describe 'POST #update' do
      it 'does not assign the requested answer to @answer' do
        patch :update, params: { id: answer,  answer: attributes_for(:answer) }
        expect(assigns(:answer)).not_to eq answer
      end
    end

    describe 'DELETE #destroy' do
      let!(:answer) { create(:question) }

      it "does not delete the answer" do
        expect { delete :destroy, params: { id: answer } }.not_to change(Answer, :count)
      end
    end
  end

end
