class V1::RecentFriendshipSerializer < ActiveModel::Serializer
  attributes :id,
             :friending_user,
             :name

  def friending_user
    User.find(object.following_user_id)
  end

  def name
    friendship = Friendship.find_by_following_user_id_and_followed_user_id(scope.id, object.following_user_id)
    if friendship
      friendship.followed_user_name
    else
      ''
    end
  end

  has_one :friending_user, serializer: V1::UserSerializer
end
