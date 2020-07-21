require 'rails_helper'

feature 'User can create answer the question', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given(:user1) { create(:user) }

    describe 'Authenticated user' do
      background do
        sign_in(user)

        visit question_path(question)
      end

      scenario 'answer the question' do
        fill_in 'Body', with: 'text text text'
        click_on 'To answer'

        expect(page).to have_content 'Your answer successfully created.'
        within '.a-body' do
          expect(page).to have_content 'text text text'
        end
        expect(page).to have_current_path question_path(question)
      end

      scenario 'answers cd a answer with errors' do
        click_on 'To answer'
        expect(page).not_to have_css '.a-body'
        expect(page).to have_current_path question_path(question)
      end

    end

    scenario 'Unauthenticated user tries to answer a question' do
      visit question_path(question)
      click_on 'To answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    describe 'Not author' do
      given!(:answer) { create(:answer, question: question) } 

      scenario  "can't destroy answer" do
        sign_in(user1)
        visit question_path(question)
        click_on('Destroy answer', match: :first)
        expect(page).to have_content "You can't destroy answer"
        expect(page).to have_current_path question_path(question)
      end
    end

  describe 'Author' do
    background do
      sign_in(user)

      visit question_path(question)
      fill_in 'Body', with: 'MyText'
      click_on 'To answer'
    end

    scenario 'can destroy question' do
      click_on 'Destroy answer'

      expect(page).to have_content 'Answer was destroyed'
      expect(page).to have_current_path question_path(question)
    end
  end

end