require 'rails_helper'

feature 'User can browse questions', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }
  given!(:question1) { create(:question) }
  given!(:question2) { create(:question) }

    scenario 'authenticated can browse answers' do
      sign_in(user)
      visit questions_path
      expect(page).to have_content 'TitleBody'
      expect(page).to have_content 'MyStringMyText'
      expect(page).to have_content 'MyStringMyText'
    end

    scenario 'unauthenticated can browse answers' do
      visit questions_path
      expect(page).to have_content 'TitleBody'
      expect(page).to have_content 'MyStringMyText'
      expect(page).to have_content 'MyStringMyText'
    end
end