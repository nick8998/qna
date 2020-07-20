require 'rails_helper'

feature 'User can sign out', %q{
  In order to ask questions
  As an unauthenticated user
  I'd like to be able to sign out
} do

  given(:user) { create(:user) }

  background { visit root_path }
  
  scenario 'User tries to sign out' do
    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end

end