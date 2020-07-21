require 'rails_helper'

feature 'User can browse answers', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answer1) { create(:answer, question: question) }
  given!(:answer2) { create(:answer, question: question) }
  
    scenario 'Authenticated user can browse answers' do
      sign_in(user)
      visit question_path(question)
      expect(page).to have_content 'Body'
      expect(page).to have_content 'MyText'
      expect(page).to have_content 'MyText'
    end

    scenario 'Unauthenticated user can browse answers' do
      visit question_path(question)
      expect(page).to have_content 'Body'
      expect(page).to have_content 'MyText'
      expect(page).to have_content 'MyText'
    end
end
