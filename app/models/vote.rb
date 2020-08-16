class Vote < ApplicationRecord
  belongs_to :votable, polymorphic: true

  has_many :votes_users, dependent: :destroy
  has_many :users, through: :votes_users, dependent: :destroy

  validates :votes_up, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :votes_down, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
