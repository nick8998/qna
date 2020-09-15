class Api::V1::ProfilesController < Api::V1::BaseController
  skip_authorization_check
  def me
    render json: current_resource_owner, serializer: MeSerializer
  end
 
end