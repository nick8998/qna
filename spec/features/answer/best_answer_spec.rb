require 'rails_helper'

feature 'User can browse answers', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }
  given!(:answer) { create(:answer, question: question) }
  
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
      click_on "Best"
      expect(page).to have_css(".a-best-body")
      expect(page).to have_link("Best", count: 1)
    end

    given!(:answer2) { create(:answer, question: question, best: true) }
    scenario "Best answer is first", js: true do
      visit question_path(question)
      expect(page).to have_css(".a-best-body") 
    end
end
