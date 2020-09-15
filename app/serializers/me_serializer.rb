class MeSerializer < ActiveModel::Serializer
  attributes :id, :email, :admin, :created_at, :updated_at, :other_users

  def other_users
    User.where.not(id: object.id)
  end
end


=begin
{
"access_token": "JRyTstMLVPHKzvq9RejmGazk_rQyiocyB0j1CB3Kxjg",
"token_type": "Bearer",
"expires_in": 86400,
"scope": "'",
"created_at": 1600095652
}
=end