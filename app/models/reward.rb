class Reward < ApplicationRecord

  validates :title, :picture, presence: true
end
