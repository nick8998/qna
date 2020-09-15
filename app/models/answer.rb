class Answer < ApplicationRecord
  include VotableModel
  has_many :votes, dependent: :destroy, as: :votable
  has_many :comments, dependent: :destroy, as: :commentable

  belongs_to :author, class_name: "User", optional: true 
  belongs_to :question

  has_many :links, dependent: :destroy, as: :linkable
  has_many_attached :files
  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  
  scope :best_answer_first, -> { order(best: :desc, created_at: :asc) }

  validates :body, presence: true

  def choose_best
    ActiveRecord::Base.transaction do
      old_best_answer = question.answers.find_by(best: true)
      if old_best_answer && old_best_answer != self
        old_best_answer.update!(best: false)
        question.reward.user_id = nil if question.reward.present?
      end
      update!(best: true)
      author.rewards << question.reward if question.reward.present?
    end
  end
end
