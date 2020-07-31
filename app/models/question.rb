class Question < ApplicationRecord
  belongs_to :author, class_name: "User", optional: true 

  has_many :answers, dependent: :destroy

  validates :title, :body, presence: true 

  def best_answers?
    self.answers.where(best: true).count == 1
  end
end
