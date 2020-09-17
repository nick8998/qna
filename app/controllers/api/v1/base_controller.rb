class Api::V1::BaseController < ApplicationController
  before_action :doorkeeper_authorize!
  
  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  private

  def current_resource_owner
    @current_resource_owner ||= current_user
  end
end