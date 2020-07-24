require 'rails_helper'

feature 'Author can delete question', %q{
  In order to delete question 
  As an author
  I'd like to be able to delete question
} do
  given(:user1) {create(:user)}
  given(:user) {create(:user)}

    describe 'Not author' do
      given!(:question) { create(:question) } 

      scenario  "can't destroy answer" do
        sign_in(user)
        visit question_path(question)
        expect(page).not_to have_content "Destroy question"
      end
    end

    describe 'Author' do
      given!(:question) { create(:question, author: user) }
      background do
        sign_in(user)
        visit question_path(question)
      end

      scenario 'can destroy question' do
        click_on 'Destroy question'

        expect(page).to have_content 'Question was destroyed'
        expect(page).to have_current_path questions_path
        expect(page).not_to have_content(question.title)
        expect(page).not_to have_content(question.body)
      end
    end
end