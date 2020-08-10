require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do

  given(:user) { create(:user) }
  given(:gist_url) { 'https://gist.github.com/nick8998/521d82a43ca5854899666d91bf757b03' }
  given(:google_url) { 'http://google.com' }

  scenario 'User adds link when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: google_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: google_url
  end

  scenario 'User adds some links when asks question', js: true do
    sign_in(user)

    visit new_question_path

    click_on 'add link'
    expect(page).to have_content 'Name', count: 2
    expect(page).to have_content 'Url', count: 2
  end

  scenario 'User adds invalid url when asks question', js: true do
    sign_in(user)

    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: "My url"

    click_on 'Ask'

    expect(page).to have_content 'Links url is not a valid URL'
  end

  scenario 'User adds gist url when asks question', js: true do
    sign_in(user)

    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Name', with: 'My gist'
    fill_in 'Url', with: gist_url

    click_on 'Ask'

    expect(page).to have_content 'My gist'
    expect(page).to have_content("Hello world")
  end

end