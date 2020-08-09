require 'rails_helper'

feature 'User can edit his answer', %q{
  In order to correct mistakes
  As an author of answer
  I'd like ot be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question, author: user) }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  describe 'Not author' do
      given!(:answer) { create(:answer, question: question) } 

      scenario  "can't destroy answer" do
        sign_in(user)
        visit question_path(question)
        expect(page).to_not have_link 'Edit'
      end
    end

  describe 'Author', js: true do
    given!(:user1) { create(:user) }
    given!(:answer1) { create(:answer, question: question, author: user1) }
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'edits his answer' do
          click_on 'Edit'

          within '.answers' do
            fill_in 'Your answer', with: 'edited answer'
            click_on 'Save'

            expect(page).to_not have_content answer.body
            expect(page).to have_content 'edited answer'
            expect(page).to_not have_selector 'textarea'         
          end
          expect(page).to have_content "You answer was updated"
          expect(page).to have_current_path question_path(question)
        end

    scenario 'edits his answer with errors' do
      click_on 'Edit'

          within '.answers' do
            fill_in 'Your answer', with: ""
            click_on 'Save'
            expect(page).to have_selector 'textarea'
          end
          expect(page).to have_content "Body can't be blank"
          expect(page).to have_current_path question_path(question)
    end
      scenario 'edits his answer with attached file' do
        click_on 'Edit'
        within '.answers' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
        end
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
      scenario 'can destroy attached files' do
        click_on 'Edit'
        within '.answers' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
        end
        click_on 'Edit'
        within '.answers' do
            click_on 'Delete file', match: :first
            click_on 'Save'
        end
        expect(page).not_to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
  end    
end