require 'rails_helper'

RSpec.describe AnswersController, type: :controller do

  describe 'Authenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question) }
    let(:answer) { create(:answer, question: question, author: user) }


    describe 'POST #create' do
      before { login(user) }

      context 'with valid attributes' do
        it 'save a new answer in the database' do
          question = create(:question)
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id, author_id: user.id }, format: :json }.to change(question.answers, :count).by(1)
          expect { post :create, params: { answer: attributes_for(:answer), question_id: question.id, author_id: user.id }, format: :json }.to change(user.authored_answers, :count).by(1)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the answer' do
          expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }, format: :json}.to_not change(Answer, :count)
        end

        it 'redirects to question' do
          post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }, format: :json

          expect(assigns(:answer)).not_to eq answer
        end
      end
    end

    describe 'PATCH #update' do
      before { login(user) }
      context 'Author' do
        context 'with valid attributes' do
          it 'assigns the requested answer to @answer' do
            patch :update, params: { id: answer,  answer: attributes_for(:answer) }, format: :js
            expect(assigns(:answer)).to eq answer
          end

          it 'changes answer attributes' do
            patch :update, params: { id: answer,  answer: { body: 'new body' } }, format: :js
            answer.reload

            expect(answer.body).to eq 'new body'
          end

          it 'renders update view' do
            patch :update, params: { id: answer,  answer: attributes_for(:answer)  }, format: :js

            expect(response).to render_template :update
          end
        end

        context 'with invalid attributes' do
          before { patch :update, params: { id: answer,  answer: attributes_for(:answer, :invalid), format: :js  } }
          it 'does not change answer' do
            expect(answer.body).to eq answer.body
          end

          it 're-renders edit view' do
            expect(response).to render_template :update
          end
        end
      end
      context "Not author" do
        let(:user1) { create(:user) }
        before { login(user1) }
        let!(:answer) { create(:answer, question: question, author: user) }
        it 'updates the answer' do
          patch :update, params: { id: answer,  answer: { body: "new body" }, format: :js  }
          expect(answer.body).not_to eq "new body"
        end
        it 'redirect to question show view' do
          patch :update, params: { id: answer,  answer: { body: "new body" }, format: :js  }
          expect(response).to render_template :update
        end
      end
    end

    describe 'PATCH #update_best' do
      context 'Author' do
        before { login(user) }
        let!(:question1) { create(:question, author: user) }
        let!(:answer1) { create(:answer, question: question1) }
        it 'assigns the requested answer to @answer' do
          patch :update_best, params: { id: answer1 }, format: :js
          
          expect(answer1.reload.best).to eq true
        end

        it 'renders update view' do
          patch :update_best, params: { id: answer1 }, format: :js

          expect(response).to render_template :update_best
        end
      end

        context "Not author" do
          let(:user1) { create(:user) }
          before { login(user1) }
          it 'updates to best answer' do
            patch :update_best, params: { id: answer }, format: :js
            expect(answer.reload.best).to eq false
          end
          it 'redirect to question show view' do
            patch :update_best, params: { id: answer,  answer: attributes_for(:answer) }, format: :js
            expect(response).to render_template :update_best
          end
      end
    end

    describe 'DELETE #destroy' do
      context 'Author' do
        before { login(user) }
        let!(:answer) { create(:answer, question: question, author: user) }

        it 'deletes the answer' do
          expect { delete :destroy, params: { id: answer }, format: :js }.to change(user.authored_answers, :count).by(-1)
        end
        it 'redirect to question show view' do
        delete :destroy, params: { id: question }, format: :js
        expect(response).to render_template :destroy
        end
      end

      context "Not author" do
        let(:user1) { create(:user) }
        before { login(user1) }
        let!(:answer) { create(:answer, question: question, author: user) }
        it 'deletes the answer' do
          expect { delete :destroy, params: { id: answer }, format: :js }.not_to change(Answer, :count)
        end
        it 'redirect to question show view' do
          delete :destroy, params: { id: question }, format: :js
          expect(response).to render_template :destroy
        end
    end
  end

  describe 'Unauthenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author: user) }
    let(:answer) { create(:answer, question: question, author: user) }

    describe 'POST #create' do
      it 'does not save a new answer in the database' do
        expect { post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question.id, author_id: user.id }}.to_not change(Answer, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PATCH #update' do
      it 'does not assign the requested answer to @answer' do
        patch :update, params: { id: answer,  answer: attributes_for(:answer) }
        expect(assigns(:answer)).not_to eq answer
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'PATCH #update_best' do
      it 'does not assigns the requested answer to @answer' do
        patch :update_best, params: { id: answer,  answer: attributes_for(:answer) }
        expect(assigns(:answer)).not_to eq answer
        expect(response).to redirect_to new_user_session_path
      end
    end

    describe 'DELETE #destroy' do
      let!(:answer) { create(:answer, question: question, author: user) }

      it "does not delete the answer" do
        expect { delete :destroy, params: { id: answer } }.not_to change(Answer, :count)
        expect(response).to redirect_to new_user_session_path
      end
    end


  end
end
end
