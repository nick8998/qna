class VotesController < ApplicationController

  include Votable
  before_action :authenticate_user!
  

  def vote_up
    if author_exist?
      update_and_add_user
    end
    render_json_voting
  end

  def vote_down
    if author_exist?
      update_and_add_user(:votes_down, @vote.votes_down, false)
    end
    render_json_voting
  end

  def vote_cancel
    cancel
    render_json_voting
  end

  
end
