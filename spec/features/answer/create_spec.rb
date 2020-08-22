require 'rails_helper'

feature 'User can create answer the question', %q{
  In order to give answer to a community
  As an authenticated user
  I'd like to be able to create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }

    describe 'Authenticated user', js:true do
      background do
        sign_in(user)

        visit question_path(question)
      end

      scenario 'answer the question' do
        fill_in 'Body', with: 'text text text'
        click_on 'To answer'
        
        expect(page).to have_content 'text text text'
        
        expect(page).to have_current_path question_path(question)
      end

      scenario 'answers cd a answer with errors' do
        click_on 'To answer'
        expect(page).to have_content "Body can't be blank"
        expect(page).to have_current_path question_path(question)
      end

      
    end

    scenario 'Unauthenticated user tries to answer a question' do
      visit question_path(question)
      click_on 'To answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
end