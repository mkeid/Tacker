class V1::RequestSerializer < ActiveModel::Serializer
  attributes :id,
             :kind,
             #:latitude,
             #:longitude,
             :name,
             :requesting_user

  has_one :requesting_user, serializer: V1::UserSerializer

  def name
    friendship = Friendship.find_by_following_user_id_and_followed_user_id(scope.id, object.requesting_user_id)
    if friendship
      friendship.followed_user_name
    else
      ''
    end
  end

end
