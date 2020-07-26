require 'rails_helper'

feature 'Author can delete answer', %q{
  In order to delete answer 
  As an author
  I'd like to be able to delete answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

    scenario 'Unauthenticated can not edit answer' do
      visit question_path(question)

      expect(page).to_not have_link 'Edit'
    end

    describe 'Not author', js: true do
      given!(:answer) { create(:answer, question: question) } 

      scenario  "can't destroy answer" do
        sign_in(user)
        visit question_path(question)
        expect(page).not_to have_content "Destroy answer"
      end
    end

  describe 'Author', js: true do
    given!(:answer) { create(:answer, question: question, author: user) }
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'can destroy answer' do
      click_on 'Destroy answer'

      expect(page).to have_content 'Answer was destroyed'
      expect(page).to have_current_path question_path(question)
      expect(page).not_to have_content(answer.body)
    end
  end
end