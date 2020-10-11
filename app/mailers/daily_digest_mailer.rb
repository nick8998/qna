class DailyDigestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.daily_digest_mailer.digest.subject
  #
  def digest(user)

    Question.where('created_at > ?', Time.now - 24.hours).each do |question|
      @greeting = "Заголовок вопроса : #{question.title}
                  Вопрос: #{question.body}
                  Email Автора: #{question.author.email}"
    end

    mail to: user.email
  end
end
