require 'rails_helper'

feature 'Author can delete answer', %q{
  In order to delete answer 
  As an author
  I'd like to be able to delete answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

    describe 'Not author' do
      given!(:answer) { create(:answer, question: question) } 

      scenario  "can't destroy answer" do
        sign_in(user)
        visit question_path(question)
        expect(page).not_to have_content "Destroy answer"
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