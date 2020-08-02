class Answer < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true 
  belongs_to :question

  scope :best_answer_first, -> (question) { joins(:question).where(question: question).order(best: :desc) }

  validates :body, presence: true

  def choose_best
    ActiveRecord::Base.transaction do
      if question.answers.where(best: true).count == 1
        best_answer = question.answers.where(best: true).first
        best_answer.update!(best: false)
      end
      self.update!(best: true)
    end
  end
end
