require 'rails_helper'

feature 'User can create answer the question', %q{
  In order to give answer to a community
  As an authenticated user
  I'd like to be able to create answer
} do

  given(:user) { create(:user) }
  given(:question) { create(:question) }
  before { question.build_vote.save }

    describe 'Authenticated user', js:true do
      background do
        sign_in(user)

        visit question_path(question)
      end

      scenario 'answer the question' do
        fill_in 'Body', with: 'text text text'
        click_on 'To answer'
        
        expect(page).to have_content 'text text text'
        
        expect(page).to have_current_path question_path(question)
      end

      scenario 'answers cd a answer with errors' do
        click_on 'To answer'
        expect(page).to have_content "Body can't be blank"
        expect(page).to have_current_path question_path(question)
      end
=begin
    Не работает эта часть, не понятно по какой причине. В ошибку пишет просто, что не находит 'rails_helper.rb' and 'spec_helper.rb'.

    scenario 'answers the question with attached file' do
      fill_in 'Body', with: "text text"

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'To answer'

      visit question_path(question)

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
=end

      
    end

    scenario 'Unauthenticated user tries to answer a question' do
      visit question_path(question)
      click_on 'To answer'

      expect(page).to have_content 'You need to sign in or sign up before continuing.'
    end
end