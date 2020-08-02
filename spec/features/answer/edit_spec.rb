require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Not author' do
      given!(:answer) { create(:answer, question: question) } 

      scenario  "can't destroy answer" do
        sign_in(user)
        visit question_path(question)
        expect(page).to_not have_link 'Edit'
      end
    end

  describe 'Author', js: true do
    given!(:user1) { create(:user) }
    given!(:answer1) { create(:answer, question: question, author: user1) }
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'edits his answer' do
          click_on 'Edit'

          within '.answers' do
            fill_in 'Your answer', with: 'edited answer'
            click_on 'Save'

            expect(page).to_not have_content answer.body
            expect(page).to have_content 'edited answer'
            expect(page).to_not have_selector 'textarea'         
          end
          expect(page).to have_current_path question_path(question)
        end

    scenario 'edits his answer with errors' do
      click_on 'Edit'

          within '.answers' do
            fill_in 'Your answer', with: ""
            click_on 'Save'
            expect(page).to have_selector 'textarea'
          end
          expect(page).to have_content "Body can't be blank"
          expect(page).to have_current_path question_path(question)
    end

    scenario "tries to edit other user's answer" do
      expect(page).to have_link('Edit', count: 1)
      expect(page).to have_current_path question_path(question)
    end
  end    
end