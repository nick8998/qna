class Answer < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true 
  belongs_to :question

  scope :best_answer_first, -> (question) { joins(:question).where(question: question).order(best: :desc) }

  validates :body, presence: true

  def choose_best(question)
    if question.answers.where(best: true).count == 1
      answer = question.answers.where(best: true).first
      best_answer = question.answers.find(answer.id)
      ActiveRecord::Base.transaction do 
        best_answer.update!(best: false)
        self.update!(best: true)
      end
    else
      self.update!(best: true)
    end
  end
end
