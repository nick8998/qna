class Question < ApplicationRecord

  include VotableModel
  has_many :votes, dependent: :destroy, as: :votable
  has_many :comments, dependent: :destroy, as: :commentable

  has_many :subscriptions, dependent: :destroy
  has_many :users, through: :subscriptions, dependent: :destroy

  belongs_to :author, class_name: "User", optional: true 

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :title, :body, presence: true 

  after_create :calculate_reputation, :subscribe


  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end

  def subscribe
    subscriber = Subscription.new(question: self, user: author)
    subscriber.save!
  end
end
