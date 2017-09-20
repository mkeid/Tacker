class BlockedUser < ActiveRecord::Base

  belongs_to :blocked_user,
             class_name: 'User',
             foreign_key: :blocked_user_id
  belongs_to :blocked_user_user,
             class_name: 'User',
             foreign_key: :blocked_user_id

  belongs_to :blocking_user,
             class_name: 'User',
             foreign_key: :blocking_user_id

  before_create { |blocked_user| Friendship.destroy_all "following_user_id = #{blocked_user.blocking_user_id} AND followed_user_id = #{blocked_user.blocked_user_id}"}
  before_create { |blocked_user| Friendship.destroy_all "following_user_id = #{blocked_user.blocked_user_id} AND followed_user_id = #{blocked_user.blocking_user_id}"}

end
