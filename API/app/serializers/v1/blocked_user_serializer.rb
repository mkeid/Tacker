class V1::BlockedUserSerializer < ActiveModel::Serializer
  attributes :id,
             :blocked_user

  has_one :blocked_user, serializer: V1::UserSerializer
end
