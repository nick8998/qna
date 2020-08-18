require 'rails_helper'

feature 'Author can edit his question', %q{
  In order to correct mistakes
  As an author of question
  I'd like ot be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:user1) { create(:user) }
  before { question.build_vote.save }

  scenario 'Unauthenticated can not edit answer' do
    visit question_path(question)
    expect(page).to_not have_link 'Edit'
  end

  describe 'Not author', js: true do
      scenario  "can't edit question" do
        sign_in(user1)
        visit question_path(question)
        expect(page).to_not have_link 'Edit'
      end
      scenario 'can choose best answer' do
        expect(page).to_not have_link 'Best'
      end
    end

  describe 'Author', js: true do
    given!(:question1) { create(:question, author: user1) }
    given!(:answer) { create(:answer, question: question) }
    before { answer.build_vote.save }

    background do
      sign_in(user)
      visit question_path(question)
    end
    scenario 'edits his question' do
          click_on 'Edit'
          within '.question' do
            fill_in 'Your question title', with: 'edited question title'
            fill_in 'Your question body', with: 'edited question body'
            click_on 'Save'
            expect(page).to_not have_content question.title
            expect(page).to_not have_content question.body
            expect(page).to_not have_selector 'textarea'         
          end
          expect(page).to have_content 'edited question title'
          expect(page).to have_content 'edited question body'
          expect(page).to have_content "Your question was updated"
          expect(page).to have_current_path question_path(question)
        end

    scenario 'edits his question with errors' do
      click_on 'Edit'
      within '.question' do
        fill_in 'Your question title', with: ''
        fill_in 'Your question body', with: ''
        click_on 'Save'
        expect(page).to have_selector 'textarea'
      end
      expect(page).to have_content "Body can't be blank"
      expect(page).to have_content "Title can't be blank"
      expect(page).to have_current_path question_path(question)
    end

    scenario 'edit a question with attached file' do
        click_on 'Edit'
        within '.question' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
        end

        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end

      scenario 'can destroy attached files' do
        click_on 'Edit'
        within '.question' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
        end
        click_on 'Edit'
        within '.question' do
            click_on 'Delete file', match: :first
            click_on 'Save'
        end
        expect(page).not_to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
      end
  end    
end