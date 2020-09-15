class MeSerializer < ActiveModel::Serializer
  attributes :id, :email, :admin, :created_at, :updated_at, :other_users

  def other_users
    User.where.not(id: object.id)
  end
end
