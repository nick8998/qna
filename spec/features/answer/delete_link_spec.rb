require 'rails_helper'

feature 'User can delete links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to delete links
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given(:google_url) { 'http://google.com' }

   describe 'Author', js:true do
      background do
        sign_in(user)

        visit question_path(question)
        fill_in 'Body', with: 'My answer'

        fill_in 'Name', with: 'My gist'
        fill_in 'Url', with: google_url

        click_on 'To answer'
      end
        scenario 'deletes link when edit an answer', js: true do
          click_on 'Edit'

          click_on 'remove link', match: :first
          click_on 'Save'

          expect(page).not_to have_link 'My gist', href: google_url
        end
  end
end