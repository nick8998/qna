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
        expect(page).to have_content 'text text text'
      end

      scenario 'asks cd a answer with errors' do
        click_on 'To answer'
        expect(page).to have_content "Body can't be blank"
      end
    end

    scenario 'Unauthenticated user tries to ask a question' do
      visit question_path(question)
      click_on 'To answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end

    describe 'User' do
      background do
        sign_in(user)

        visit question_path(question)
        fill_in 'Body', with: 'text text text'
        click_on 'To answer'
        visit question_path(question)
        fill_in 'Body', with: 'text text text1'
        click_on 'To answer'
      end

      scenario 'authenticated can browse answers' do
        expect(page).to have_content 'Body'
        expect(page).to have_content 'text text text'
        expect(page).to have_content 'text text text1'
      end

      scenario 'unauthenticated can browse answers' do
        click_on 'Logout' 
        visit question_path(question)
        expect(page).to have_content 'Body'
        expect(page).to have_content 'text text text'
        expect(page).to have_content 'text text text1'
      end

      scenario  "can't destroy answer" do
        click_on 'Logout'
        sign_in(user1)
        visit question_path(question)
        click_on('Destroy answer', match: :first)
        expect(page).to have_content "You can't destroy answer"
      end
    end

    describe 'Author' do
      background do
        sign_in(user)

        visit question_path(question)
        fill_in 'Body', with: 'text text text'
        click_on 'To answer'
      end

      scenario 'can destroy question' do
        click_on 'Destroy answer'

        expect(page).to have_content 'Answer was destroyed'
      end
    end



end