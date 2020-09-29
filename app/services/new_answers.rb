class NewAnswers
  def send_answers
    Subscription.find_each do |sub|
      unless sub.question.answers.where("created_at < ?", Time.now - 1.hour).nil?
        NewAnswersMailer.new_answers(sub.question)
      end
    end
  end
end