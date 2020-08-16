require 'rails_helper'

feature 'User can delete links to answer', %q{
  In order to provide additional info to my answer
  As an question's author
  I'd like to be able to delete links
} do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  before { question.vote = Vote.new }
  given!(:answer) { create(:answer, question: question, author: user, links_attributes: [ {name: "Google", url: "https://google.com"} ]) }
  before { answer.vote = Vote.new }


   describe 'Author', js:true do
      background do
        sign_in(user)

        visit question_path(question)
      end
        scenario 'deletes link an answer', js: true do
          click_on 'Delete link'

          expect(page).not_to have_link 'Google', href: "https://google.com"
        end
  end
end