require 'rails_helper'

feature 'Author can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:user1) { create(:user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Not author', js: true do
      scenario  "can't edit question" do
        sign_in(user1)
        visit question_path(question)
        expect(page).to_not have_link 'Edit'
      end
      scenario 'can choose best answer' do
        expect(page).to_not have_link 'Best'
      end
    end

  describe 'Author', js: true do
    given!(:question1) { create(:question, author: user1) }
    given!(:answer) { create(:answer, question: question) }

    background do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'edits his question' do
          click_on 'Edit'
          within '.question' do
            fill_in 'Your question title', with: 'edited question title'
            fill_in 'Your question body', with: 'edited question body'
            click_on 'Save'
            expect(page).to_not have_content question.title
            expect(page).to_not have_content question.body
            expect(page).to_not have_selector 'textarea'         
          end
          expect(page).to have_content 'edited question title'
          expect(page).to have_content 'edited question body'
          expect(page).to have_current_path question_path(question)
        end

    scenario 'edits his question with errors' do
      click_on 'Edit'

          within '.question' do
            fill_in 'Your question title', with: ''
            fill_in 'Your question body', with: ''
            click_on 'Save'
            expect(page).to have_selector 'textarea'
          end
          expect(page).to have_content "Body can't be blank"
          expect(page).to have_content "Title can't be blank"
          expect(page).to have_current_path question_path(question)
    end

    scenario "tries to edit other user's question" do
      expect(page).to have_link('Edit', count: 1)
      expect(page).to have_current_path question_path(question)
    end
  end    
end