class V1::MeSerializer < ActiveModel::Serializer
  attributes :id,
             :blocked_users,
             :email,
             :friendships,
             :is_private,
             :name,
             :phone_number,
             :recent_friendships,
             :requests,
             :trackers,
             :username

  has_many :blocked_users, serializer: V1::BlockedUserSerializer
  has_many :friendships, serializer: V1::FriendshipSerializer
  has_many :recent_friendships, serializer: V1::RecentFriendshipSerializer
  has_many :requests, serializer: V1::RequestSerializer
  has_many :trackers, serializer: V1::TrackerSerializer

end
