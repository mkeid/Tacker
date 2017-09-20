class V1::TrackerSerializer < ActiveModel::Serializer
  attributes :id,
             :latitude,
             :longitude,
             :name,
             :seen,
             :tracked_user,
             :updated_at

  has_one :tracked_user, serializer: V1::UserSerializer

  def name
    if Friendship.exists?(following_user_id: scope.id, followed_user_id: object.tracked_user_id)
      friendship = Friendship.find_by_following_user_id_and_followed_user_id(scope.id, object.tracked_user_id)
      friendship.followed_user_name
    else
      ''
    end
  end

end
