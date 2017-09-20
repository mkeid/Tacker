class V1::FriendshipSerializer < ActiveModel::Serializer
  attributes :id,
             :friended_user,
             :name

  has_one :friended_user, serializer: V1::UserSerializer

  def name
    object.followed_user_name
  end
end
