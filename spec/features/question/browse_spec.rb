require 'rails_helper'

feature 'User can browse questions', %q{
  In order to get answer from a community
  As an authenticated user
  I'd like to be able to ask the question
} do

  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 5) }
  before { questions.each do |q|
            q.build_vote.save
            end }

    scenario 'authenticated can browse questions' do
      sign_in(user)
      visit questions_path
      expect(page).to have_content 'TitleBody'
      questions.each do |q|
        expect(page).to have_content q.title
        expect(page).to have_content q.body
      end
    end

    scenario 'unauthenticated can browse questions' do
      visit questions_path
      expect(page).to have_content 'TitleBody'
      questions.each do |q|
        expect(page).to have_content q.title
        expect(page).to have_content q.body
      end
    end
end