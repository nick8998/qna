require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to add links
} do

  given(:user) {create(:user)}
  given!(:question) {create(:question)}
  given(:gist_url) { 'https://gist.github.com/nick8998/521d82a43ca5854899666d91bf757b03' }
  given(:google_url) { 'http://google.com' }

  scenario 'User adds link when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'My answer'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: google_url

    click_on 'To answer'

    within '.answers' do
      expect(page).to have_link 'My gist', href: google_url
    end
  end

  scenario 'User adds some links when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    click_on 'add link'

    within '.new-answer' do
      expect(page).to have_content 'Name', count: 2
      expect(page).to have_content 'Url', count: 2
    end
  end

  scenario 'User adds invalid url when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'My answer'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: "My url"

    click_on 'To answer'

    expect(page).to have_content 'Links url is not a valid URL'
  end

  scenario 'User adds gist url when give an answer', js: true do
    sign_in(user)

    visit question_path(question)

    fill_in 'Body', with: 'My answer'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'To answer'

    visit question_path(question)
    within '.new-answer' do
      expect(page).to have_content 'My gist'
      expect(page).to have_content("Hello world")
    end
  end
end