require 'rails_helper'

feature 'User can sign up', %q{
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign up
} do

  given(:user) { create(:user) }

  background { visit new_user_registration_path }
  
  scenario 'Unregistered user tries to sign up' do
    fill_in 'Email', with: "user@test.com"
    fill_in 'Password', with: "12345678"
    fill_in 'Password confirmation', with: "12345678"

    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end

  scenario 'Registered user tries to sign up' do
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation

    click_on 'Sign up'

    save_and_open_page
    expect(page).to have_content 'Sign up'
  end 
end