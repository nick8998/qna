require 'rails_helper'

feature 'User can vote for question', %q{
  In order to vote for question
  As an user
  I'd like to be able to vote for question
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, author: user) }  
  given(:user1) { create(:user) }
  given(:user2) { create(:user) }
    
    scenario "Unauthenticated user can't vote for question" do
      visit question_path(question)
      expect(page).not_to have_link "Up"
      expect(page).not_to have_link "Down"
      expect(page).not_to have_link "Cancel"
    end

    scenario "Result in voting is right", js:true do
      sign_in(user1)
      visit question_path(question)
      click_on "Up"
      click_on 'Logout'
      sign_in(user2)
      visit question_path(question)
      click_on "Down"
      within '.voting-result' do
        expect(page).to have_content("0")
      end 
    end

    describe "Authenticated user", js: true do
      background do
      sign_in(user1)
      visit question_path(question)
    end
    
      scenario "can vote for question with right positive result" do
        within '.voting' do
          expect(page).to have_link "Up"
          expect(page).to have_link "Down"

          click_on "Up"
          expect(page).to have_content("1")
          expect(page).to have_link("Cancel")
        end
      end
      scenario "can vote for question with right negative result" do
        within '.voting' do
          click_on "Down"
          expect(page).to have_content("-1")
          expect(page).to have_link("Cancel")
        end
      end

      scenario "can vote positive only one time" do
        within '.voting' do
          click_on "Up"
          expect(page).not_to have_link("Up")
          expect(page).not_to have_link("Down")
          expect(page).to have_link("Cancel")
        end
      end
      scenario "can vote negative only one time" do
        within '.voting' do
          click_on "Down"
          expect(page).not_to have_link("Up")
          expect(page).not_to have_link("Down")
          expect(page).to have_link("Cancel")
        end
      end

      scenario "can cancel" do
        within '.voting' do
          click_on "Up"
          click_on "Cancel"
          expect(page).to have_content("Голос был отменен")
          expect(page).not_to have_link("Cancel")
        end
        visit question_path(question)
        within '.voting-result' do
          expect(page).to have_content("0")
          expect(page).not_to have_link("Cancel")
        end
      end
  end


    scenario "Author can't vote for question" do
      sign_in(user)
      visit question_path(question)
      expect(page).not_to have_link "Up"
      expect(page).not_to have_link "Down"
      expect(page).not_to have_link "Cancel"
    end
end