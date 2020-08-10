class Reward < ApplicationRecord
  belongs_to :question
  
  has_many :got_rewards, dependent: :destroy
  has_many :users, through: :got_rewards, dependent: :destroy

  validates :title, :picture, presence: true
end
