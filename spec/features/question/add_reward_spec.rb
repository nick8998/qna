require 'rails_helper'

feature 'User can add reward to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add reward
} do

  given(:user) { create(:user) }
  given(:picture) { "https://www.google.com/url?sa=i&url=http%3A%2F%2Fatma-marketing.hr%2F118091%2FSnow%2F&psig=AOvVaw0FxriD546vHyim6mb_sr2t&ust=1597157025863000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJix_NvvkOsCFQAAAAAdAAAAABAD" }

  scenario 'User adds reward when asks question' do
    sign_in(user)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'

    fill_in 'Reward title', with: 'My reward'
    fill_in 'Picture', with: picture

    click_on 'Ask'

    expect(page).to have_content 'My reward'
    expect(page).to have_css("img")
  end

end