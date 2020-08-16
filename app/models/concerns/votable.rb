module Votable
  extend ActiveSupport::Concern

  included do
    has_one :vote, dependent: :destroy, as: :votable
  end
end