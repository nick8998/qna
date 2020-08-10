class Reward < ApplicationRecord
  belongs_to :question
  
  has_many :got_rewards, dependent: :destroy
  has_many :users, through: :got_rewards, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true
end
