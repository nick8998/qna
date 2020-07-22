require 'rails_helper'

feature 'User can browse answers', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  given!(:answers) { create_list(:answers, 5, question: question) }
  
    scenario 'Authenticated user can browse answers' do
      sign_in(user)
      visit question_path(question)
      expect(page).to have_content 'Body'
      answers.each do |a|
        expect(page).to have_content "#{a.body}"
      end
    end

    scenario 'Unauthenticated user can browse answers' do
      visit question_path(question)
      expect(page).to have_content 'Body'
      answers.each do |a|
        expect(page).to have_content "#{a.body}"
      end
    end
end
