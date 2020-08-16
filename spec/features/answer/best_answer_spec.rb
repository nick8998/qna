require 'rails_helper'

feature 'User can choose best answer', %q{
  In order to get answer from a community
  As an author of question
  I'd like to be able to choose best answer for my question
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question) }
  before { question.vote = Vote.new }
  before { answer.vote = Vote.new }
  
  given(:user1) { create(:user) }
    
    scenario "Unauthenticated user can't choose best answer" do
      visit question_path(question)
      expect(page).not_to have_link "Best"
    end

    scenario "Authenticated user can't choose best answer" do
      sign_in(user1)
      visit question_path(question)
      expect(page).not_to have_link "Best"
    end


    scenario "Author can choose best answer", js: true do
      sign_in(user)
      visit question_path(question)
      click_on "Best", match: :first
      expect(page).to have_css(".a-best-body")
      expect(page).to have_link("Best", count: 1)
      expect(page).to have_content "This answer is best"
    end

    given!(:answer2) { create(:answer, body: "text text", question: question) }
    before { answer2.vote = Vote.new }
    scenario "Best answer is first", js: true do
      sign_in(user)
      visit question_path(question)
      all('td', text: 'Best')[1].click
      within '.a-best-body' do
        expect(page).to have_content "text text"
      end
      expect(page).to have_content "This answer is best"
    end
end
