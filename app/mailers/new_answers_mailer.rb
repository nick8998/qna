class NewAnswersMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.new_answers_mailer.new_answers.subject
  #
  def new_answers(question)
    @greeting = question.answers.last

    question.subscriptions.each do |sub|
      mail to: sub.user.email
    end
  end
end
