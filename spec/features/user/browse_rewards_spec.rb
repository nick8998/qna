require 'rails_helper'

feature 'User can browse all rewards', %q{
  In order to get reward
  As an answer's author
  I'd like to be able to get reward
} do

  given(:user) { create(:user) }

  describe 'User', js: true do
    background do
      sign_in(user)
      visit new_question_path
      fill_in 'Title', with: "Test question"
      fill_in 'Body', with: "text text"

      fill_in 'Reward title', with: "My reward"
      attach_file 'Image', "#{Rails.root}/spec/fixtures/files/image.jpg"
      click_on 'Ask'

      fill_in 'Body', with: 'text text text'
      click_on 'To answer'

      click_on 'Best'
    end


  scenario 'browse rewards' do
    visit user_rewards_path

    expect(page).to have_content "My reward"
    expect(page).to have_css("img")
  end
end
end