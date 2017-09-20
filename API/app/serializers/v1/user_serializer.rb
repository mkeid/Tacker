class V1::UserSerializer < ActiveModel::Serializer
  attributes :id,
             :is_friended,
             :is_pending,
             :is_private,
             :name,
             :phone_number,
             :username

  def is_friended
    scope.friended_users.include?(object)
  end

  def is_pending
    Request.exists?({requesting_user_id: scope.id, requested_user_id:object.id})
  end
end
