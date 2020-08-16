require 'rails_helper'

feature 'User can vote for answer', %q{
  In order to vote for answer
  As an user
  I'd like to be able to vote for answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question, author: user) }

  before { question.vote = Vote.new }
  before { answer.vote = Vote.new }
  
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
      within '.voting-answer' do
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
