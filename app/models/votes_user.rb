class VotesUser < ApplicationRecord
  belongs_to :vote
  belongs_to :user
end
