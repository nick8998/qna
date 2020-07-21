require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do

  describe 'Authenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author: user) }

    describe 'GET #index' do 
      let(:questions) { create_list(:question, 3) }

      before { get :index }
      
      it 'populates an array of all questions' do
        expect(assigns(:questions)).to match_array(questions)
      end

      it 'renders index view' do
        expect(response).to render_template :index
      end
    end

    describe 'GET #show' do
      before { get :show, params: { id: question } }

      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end
      
      it 'renders show view' do
        expect(response).to render_template :show
      end

      let(:answer) { create(:answer, question: question) }

      it 'checks the class of @answer' do
        expect(assigns(:answer).class).to eq answer.class
      end

      it 'checks association with new answer' do
        expect(assigns(:answer).question).to eq answer.question
      end
    end

    describe 'GET #new' do
      before { login(user) }
      before { get :new, params: { author_id: user.id } }
      it 'render new view' do
        expect(response).to render_template :new
      end
    end

    describe 'GET #edit' do
      
      before { login(user) }
      before { get :edit, params: { id: question, author_id: user.id } }
      it 'assigns the requested question to @question' do
        expect(assigns(:question)).to eq question
      end

      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end

    describe 'POST #create' do
      before { login(user) }
      context 'with valid attributes' do
        it 'save a new question in the database' do
          expect { post :create, params: { question: attributes_for(:question), params: { author_id: user.id } } }.to change(user.authored_questions, :count).by(1)
        end

        it 'redirects to show view' do
          post :create, params: { question: attributes_for(:question) }

          expect(response).to redirect_to assigns(:question)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the question' do
          expect { post :create, params: { question: attributes_for(:question, :invalid) } }.to_not change(Question, :count)
        end

        it 're-renders new view' do
          post :create, params: { question: attributes_for(:question, :invalid) }

          expect(response).to render_template :new
        end
      end
    end

    describe 'PACH #update' do
      before { login(user) }
      context 'with valid attributes' do
        it 'assigns the requested question to @question' do
          patch :update, params: { id: question, question: attributes_for(:question) }
          expect(assigns(:question)).to eq question
        end

        it 'changes question attributes' do
          patch :update, params: { id: question, question: { title: 'new title', body: 'new body' } }
          question.reload

          expect(question.title).to eq 'new title'
          expect(question.body).to eq 'new body'
        end

        it 'redirects to update questions' do
          patch :update, params: { id: question, question: attributes_for(:question) }

          expect(response).to redirect_to question
        end
      end

      context 'with invalid attributes' do
        before { patch :update, params: { id: question,  question: attributes_for(:question, :invalid) } }

        it 'does not change question' do
          question.reload

          expect(question.title).to eq 'MyString'
          expect(question.body).to eq 'MyText'
        end

        it 're-renders edit view' do
          expect(response).to render_template :edit
        end
      end
    end

    describe 'DELETE #destroy' do
      before { login(user) }
      let!(:question) { create(:question) }

      it 'deletes the question' do
        expect { delete :destroy, params: { id: question } }.to change(Question, :count).by(0)
      end

      it 'redirect to index view' do
        delete :destroy, params: { id: question }
        expect(response).to redirect_to questions_path
      end
    end
  end

  describe 'Unauthenticated user' do
    let(:user) { create(:user) }
    let(:question) { create(:question, author: user) }

    describe 'GET #new' do
      before { get :new }
      it 'does not render new view' do
        expect(response).not_to render_template :new
      end
    end

    describe 'GET #edit' do
      before { get :edit, params: { id: question, author_id: user.id }  }
      it 'does not assign the requested question to @question' do
        expect(assigns(:question)).not_to eq question
      end

      it 'does not render edit view' do
        expect(response).not_to render_template :edit
      end
    end

    describe 'POST #create' do
      it 'does not save a new question in the database' do
        expect { post :create, params: { question: attributes_for(:question), params: { author_id: user.id } } }.not_to change(user.authored_questions, :count)
      end
    end

    describe 'POST #update' do
      it 'does not save a new question in the database' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).not_to eq question
      end
    end

    describe 'DELETE #destroy' do
      let!(:question) { create(:question) }

      it 'does not delete the question' do
        expect { delete :destroy, params: { id: question } }.not_to change(Question, :count)
      end
    end
  end
end
