require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do


  given(:user) {create(:user)}
  given(:user1) {create(:user)}

    describe 'Authenticated user' do
      background do
        sign_in(user)

        visit questions_path
        click_on 'Ask question'
      end

      scenario 'asks a question' do
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'text text text'
        click_on 'Ask'

        expect(page).to have_content 'Your question successfully created.'
        within '.q-title' do
          expect(page).to have_content 'Test question'
        end
        within '.q-body' do
          expect(page).to have_content 'text text text'
        end
      end

      scenario 'asks cd a question with errors' do
        click_on 'Ask'

        expect(page).to have_content "Title can't be blank"
        expect(page).not_to have_css '.q-body'
        expect(page).not_to have_css '.q-title'
        expect(page).to have_current_path questions_path
      end
    end

    scenario 'Unauthenticated user tries to ask a question' do
      visit questions_path
      click_on 'Ask question'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    describe 'Not author' do
      given!(:question) { create(:question) } 

      scenario  "can't destroy answer" do
        sign_in(user1)
        click_on('Show', match: :first)
        click_on 'Destroy question'
        expect(page).to have_content "You can't destroy question"
        expect(page).to have_current_path questions_path
      end
    end

    describe 'Author' do
      background do
        sign_in(user)

        visit questions_path
        click_on 'Ask question'
        fill_in 'Title', with: 'Test question'
        fill_in 'Body', with: 'text text text'
        click_on 'Ask'
      end

      scenario 'can destroy question' do
        click_on 'Destroy question'

        expect(page).to have_content 'Question was destroyed'
        expect(page).to have_current_path questions_path
      end
    end
end
