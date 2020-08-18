require 'rails_helper'

feature 'User can vote for question', %q{
  In order to vote for question
  As an user
  I'd like to be able to vote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }

  before { question.build_vote.save }
  
  given(:user1) { create(:user) }
    
    scenario "Unauthenticated user can't vote for answer" do
      visit question_path(question)
      expect(page).not_to have_link "Up"
      expect(page).not_to have_link "Down"
      expect(page).not_to have_link "Cancel"
    end

    scenario "Authenticated user can't choose best answer", js: true do
      sign_in(user1)
      visit question_path(question)
      within '.voting-question' do
        expect(page).to have_link "Up"
        expect(page).to have_link "Down"
        expect(page).to have_link "Cancel"

        click_on "Up"
        expect(page).to have_content("1")
      end
    end


    scenario "Author can't vote for answer" do
      sign_in(user)
      visit question_path(question)
      expect(page).not_to have_link "Up"
      expect(page).not_to have_link "Down"
      expect(page).not_to have_link "Cancel"
    end
end